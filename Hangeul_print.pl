#!/usr/bin/perl

use 5.010;
use strict;
use warnings;

use Encode; # must use Encode 

print "Hello World!\n";
my $Hangeul = "한글";
my $String = decode("UTF-8",$Hangeul);
my $output = encode("cp949",$String);
print "$output \n";