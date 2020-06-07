use strict;
use warnings;

use LWP::UserAgent ();
use Mojo::DOM;

# Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:74.0) Gecko/20100101 Firefox/74.0

sub crwl2{
	my $url;
	$url = 'https://www.bing.com/images/search?q=france+paris&FORM=HDRSC2';
	my $us = my $ua = LWP::UserAgent->new();
	$ua->agent('Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:74.0) Gecko/20100101 Firefox/74.0');
	my $res = $ua->get( $url )->decoded_content;
	open(bing3, ">", "bing_3.html") or die "not open";
	my @pure_address = ();
	Mojo::DOM->new($res)->find('div')->grep(qr/div class=\"img_cont hoff\"/i)->grep(qr/data-src="https/i)->each(sub {my $src = $_; my $line; if ($src =~ /(data-src="https[^"]+")/){$line = $1; push @pure_address, $1};}); 

	my $line;
	foreach my $EA (@pure_address){
		# print $EA,"\n";
		$EA =~ s/data-src=//g;
		$EA =~ s/"//g;
		# print $EA, "\n";
		$EA =~ s/&amp;/&/g;
		print bing3 $EA, "\n";
	}
	close(bing3);
}

crwl2();


