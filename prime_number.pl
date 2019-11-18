use strict;
use warnings;
use 5.26.1;


my (@prime_number_list, $prime_number_check);
@prime_number_list = (2);
$prime_number_check = undef;

for(my $i = 3; $i < 20000; $i++){
	foreach my $prime_number (@prime_number_list){
		my $remainder = $i % $prime_number;
		if($remainder == 0){
			$prime_number_check = 0;
			last;
		} else {
			$prime_number_check = 1;
		}
	}
	if($prime_number_check != 0){
		unshift @prime_number_list, $i;
	}
}


for(my $i = 0; $i < 30; $i++){
	say $prime_number_list[$i];
}


