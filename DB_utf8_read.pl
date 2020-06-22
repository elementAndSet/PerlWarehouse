use strict;
use warnings;
use 5.26.1;
use DBI;
use Encode;

my $dbfile = 'booklist';
my $dsn = "DBI:mysql:booklist:localhost";
my $username = "root";
my $password = 'computer';

my %attr = (
	PrintError => 0,
	RaiseError => 1
	);
my ($connect_die, $prepare_die, $sql_1, $sql_2, $publisher, $authority);
$connect_die = "Error connecting to the database";
$prepare_die = "couldn't prepare statment";
$sql_1 = "SELECT * FROM a4printed WHERE authority = ? ";
$sql_2 = "SELECT * FROM dongjak_library WHERE publisher = ? ";
$publisher = "";
$authority = 'John Backus';

my $dbh = DBI->connect($dsn,$username,$password,\%attr) or die($connect_die);

$dbh->{mysql_enable_utf8} = 1;
$dbh->do('set names "UTF8"');
my @ary = $dbh->data_sources();
my $sth = $dbh->prepare($sql_1) or die $prepare_die . $dbh->errstr;
$sth->execute($authority) or die "couldn't execute statment" . $sth->errstr;
foreach my $EA(@ary){print $EA,"\n";}

my @data;
while (@data = $sth->fetchrow_array()) {
	my $zero = $data[0];
	my $cpzero = encode("cp949",$zero);
	my $First = $data[1];
	my $second = $data[2];
	print "$cpzero $First  $second \n";
}
if ($sth->rows == 0) {
	print "No matched \n";
}
$sth->execute($authority) or die "couldn't execute statment" . $sth->errstr;

my @fullData = $sth->fetchrow_array();
	print " fullData[2] : $fullData[2],  fullData[3] : $fullData[3] \n";
	@fullData = $sth->fetchrow_array();
	print " fullData : @fullData  \n";
	@fullData = $sth->fetchrow_array();
#my $String = decode("UTF-8",$fullData[0]);
#my $output = encode("cp949",$fullData[0]);
	print " fullData -> @fullData  \n";

$sth->finish;
$dbh->disconnect();
