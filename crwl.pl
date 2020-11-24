use strict;
use warnings;
use 5.30.1;
 
use LWP::UserAgent ();
use HTTP::Tiny;
use Time::HiRes;
use Mojo::DOM;
use HTML::Element;
use Encode; # must use Encode 

sub keyword_file_to_search_keyword_list{
    my $keywordfile = shift;
    my @searchkeywordlist = ();
    open(FH,"<",$keywordfile) or die 'not open file';
    while(<FH>){
        chomp($_);
        push @searchkeywordlist, $_;
    }
    close(FH);
    return @searchkeywordlist;
}

sub search_keyword_to_search_url{
    my $keyword = shift;
    $keyword =~ s/\s+/\+/;
    my $url = 'https://www.bing.com/images/search?q=' . $keyword . '&FORM=HDRSC2';
    return $url ;
}

sub search_url_to_image_url_list{
    my $search_url = shift;
	my $us = my $ua = LWP::UserAgent->new();
	$ua->agent('Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:74.0) Gecko/20100101 Firefox/74.0');
	my $res = $ua->get( $search_url )->decoded_content;
	my @pure_address = ();
	Mojo::DOM->new($res)->find('div')->grep(qr/div class=\"img_cont hoff\"/i)->grep(qr/data-src="https/i)->each(sub {my $src = $_; my $line; if ($src =~ /(data-src="https[^"]+")/){$line = $1; push @pure_address, $1};}); 

	my @image_url_list = ();
	foreach my $EA (@pure_address){
		$EA =~ s/data-src=//g;
		$EA =~ s/"//g;
		$EA =~ s/&amp;/&/g;
        push @image_url_list, $EA;
	}
    return @image_url_list;
}

sub image_url_to_download_action{
    my $url = $_[0];
    my $filename = $_[1];

    open my $out, '>', "$filename" or die "Unable to open $filename for writing.\n";
    binmode $out;
    print {$out} HTTP::Tiny->new->get($_[0])->{content};
}

sub to_cp949{
    my $Hangeul = shift;
    my $String = decode("UTF-8",$Hangeul);
    my $output = encode("cp949",$String);
    return $output;
}

sub superwork{
    my $keyword_file = shift;
    my @keyword_list = keyword_file_to_search_keyword_list($keyword_file);
    foreach (@keyword_list){
        mainwork($_);
        Time::HiRes::usleep(1000000);
    }
}

sub mainwork{
    my $search_keyword = shift;
    my $search_url = search_keyword_to_search_url($search_keyword);
    sub uniq{
        my @list = @_;
        if (scalar @list <= 1){
            return @list;
        } else{
            my $len = scalar @list;
            my @uniq = ($list[0]);
            foreach (@list){
                unless($_ eq $uniq[(scalar @uniq)-1]){
                    push(@uniq, $_);
                }
            }
            return @uniq;
        }
    }

    sub mkfolder{
        my $folder_name = shift;
        $folder_name =~ s/\s/_/g;
        mkdir($folder_name, 0777);
        return $folder_name;
    }

    my @image_url_list = search_url_to_image_url_list($search_url);
    my @image_url_uniq = uniq(@image_url_list);
    my $new_folder_name = mkfolder(to_cp949($search_keyword));
    my $index = 1;
    my $url_scalar = scalar @image_url_uniq;
    foreach(@image_url_uniq){
        subwork($new_folder_name, $index, $_, $url_scalar);
        $index++;
        Time::HiRes::usleep(1000000);
    }

}

sub subwork{
    sub test_and_delete{
        my $file = shift;
        my @stat = stat $file;
        if($stat[7] < 1024){
            unlink $file;
            return "deleted";
        }
        return "no problem";
    }

    my $subfolder = shift;
    my $fileindex = shift;
    my $url = shift;
    my $total_num = shift;
    my $filename = $subfolder . sprintf("%03s",$fileindex);
    my $path = $subfolder . '/'. $filename . '.jpeg';
    open(my $FH,">",$path) or die "error!";
    binmode($FH);
    print {$FH} HTTP::Tiny->new->get($url)->{content};
    close($FH);
    
    my $test_result = test_and_delete($path);
    if ($test_result eq "no problem"){
        say $total_num . " : ". $filename;
    }else{
        say $total_num . " : ". $filename . " <- deleted!!";
    }

    return $path;
}

# Bing에서 검색할 키워드가 있는 텍스트파일을 입력
#superwork('america_artist.txt');
