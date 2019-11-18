
use warnings;
use strict;

my @first_arr = ("\nace","\npointer",("\ndry","\nbrick"),"\nhouse");
print @first_arr;
my @second_arr = ("show",@first_arr,"\ndetail");
print @second_arr;
print "\n";
my @elevation = (19,1,2,100, 3,89,1056);
print join ", ", sort @elevation;
print "\n";
print join ", ", sort{$a <=> $b} @elevation;
print "\n";
sub hyphen{
	my $word = shift @_;
	$word = join "-", map{substr $word, $_, 1}(0 .. (length $word) - 1);
	return $word;
	}
print hyphen("extraordinary");
print "\n";
#print left_pad("hellloo", 10, "+");
