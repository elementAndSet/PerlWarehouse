#!/usr/bin/perl

use 5.010;
use strict;
use warnings;

print "Hello World!\n";
my $vocaA = "Red line Green zone";
if($vocaA =~ /Green/){
	print "It is matched \n";
}else{
	print "Match miss \n";
}

my $string = "Hello world Perl";
if($string =~ m/(\w+)\s+(\w+)\s+(\w+)/) {
    print "success \n";
}else{
	print "Fail \n";
}

$string =~ s/world/vietnam/;
print "$string \n";

my $location = 'C:\Perl_script\Making_Space\multiple_matrix.txt';
print "$location \n";
