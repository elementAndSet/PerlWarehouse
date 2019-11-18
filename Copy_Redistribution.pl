use strict;
use warnings;
use 5.26.1;

my @htmlList = glob('c:\custom\Programming\language\PHP\php_manual_en.tar\php_manual_en\php-chunked-xhtml\*.html');
my $route = "";
my @message = ();
my $FUNCTION = undef;
foreach (@htmlList){
	my $original_path = $_;
	my $path = $original_path;
	$path =~ s/^c:\\custom\\Programming\\language\\PHP\\php_manual_en.tar\\php_manual_en\\php-chunked-xhtml\\// ;
    $path =~ s/\..*\.html$//;
    $path =~ s/\.html$//;
    if ($route ne $path) {
    	print "$path\n";
    		my $systemMessage = system("mkdir c:\\Perl_Script\\phpHTML\\$path");
    #		push(@message, $systemMessage);
    		$route = $path;
    	}
    system("copy $original_path C:\\Perl_Script\\phpHTML\\$path");
    print "$original_path\n";
}

my $folder = 'exFolder';
#system("mkdir c:\\Perl_Script\\$folder");
#print "@message";