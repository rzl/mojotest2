package MyAppDB;
use DBI;

my $dbfile = File::Spec->catfile(File::Spec->curdir(), 'mojo.db');
my @pool;
my $normalcon=10;

sub new { bless {}, shift }

sub  connect_db {
	my $dbh = DBI->connect("dbi:SQLite:dbname=".$dbfile) or
    die $DBI::errstr;
	 $dbh->{sqlite_unicode} = 1;
#unicode输出，不然会出现中文乱码	 
	return $dbh;
}

sub addcon{
	my $dbh = connect_db(); 
	push @pool,$dbh;
}

sub delcon{
	my $dbh=pop @pool;
	$dbh->disconnect;
}

sub setcon{
    my($c,$num)=@_;
	while($#pool<$unm){
	$c->addcon();
	}
	while($#pool>$num){
	$c->delcon();
	}
}
sub setnormalcon{
	shift;
	$normalcon=shift;
}

sub getcon{
	if ($#pool>0) {
	my $dbh=pop @pool;
	return $dbh;
	} else {
	my $dbh=connect_db();
	return $dbh;
	}
}

sub putcon{
	my($c,$dbh)=@_;
	if ($#pool>$normalcon) {
	$dbh->disconnect;
	} else {
	push @pool,$dbh;
	}
}

sub getpoolnum{
	return $#pool;
}

sub initdata {
my $dbh = DBI->connect("dbi:SQLite:dbname=".$dbfile) or
     die $DBI::errstr;
my $table1 = '
create table if not exists entries (
  id integer primary key autoincrement,
  title string not null,
  text string not null,
  author string not null
  
);';
my $table2= '
create table if not exists users  (
  id integer primary key autoincrement,
  name string not null,
  password string not null
);
';
$dbh->do($table1) or die $dbh->errstr;
$dbh->do($table2) or die $dbh->errstr;
}

1;