
use strict;
use warnings;
use 5.26.1;

my $source_path = 'C:\Perl_script\Data\UPPER_SONDE_47122_WND_2014_2014_2015.csv';
my $target_path = 'C:\Perl_script\Data\UPPER_SONDE.txt'; 
open(CSVfile,"<",$source_path) or die "can't open source file";
open(MATRIX,">",$target_path) or die "can't open target file";

my @data = <CSVfile>;
my $data_size = scalar @data;
my @output = ("");
my $i = 0;
my @data_elements_before = split ',', $data[1];
my $date_time_before = $data_elements_before[1];
my @data_list = ("",$data_elements_before[2]);

for($i = 2; $i < $data_size; $i++){
    my @data_elements_after = split ',', $data[$i];
    my $date_time_after = $data_elements_after[1];

    if($date_time_after eq $date_time_before){
        push @data_list, $data_elements_after[2];
    }else{
        my $elements_number = (scalar @data_list) - 1;
        my $out = join ' -- ', @data_list;
        say MATRIX $date_time_before," ",$elements_number," ",$out;
        $date_time_before = $date_time_after;
        @data_list = ("");
        push @data_list, $data_elements_after[2];
    }     
}
my $out_last = join ' -- ', @data_list;
my @data_elements_last = split ',', $data[$data_size - 1];
my $date_time_last = $data_elements_last[1];
say MATRIX $date_time_last, $out_last;



close(CSVfile);
close(MATRIX);