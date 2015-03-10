package MyAppDB;
use DBI;

my $dbfile = File::Spec->catfile(File::Spec->curdir(), 'mojo.db');

sub new { bless {}, shift }

sub  connect_db {
	my $dbh = DBI->connect("dbi:SQLite:dbname=".$dbfile) or
    die $DBI::errstr;
	 $dbh->{sqlite_unicode} = 1;
#unicode输出，不然会出现中文乱码	 
	return $dbh;
}



sub initdata {
my $dbh = DBI->connect("dbi:SQLite:dbname=".$dbfile) or
     die $DBI::errstr;
my $schema = '
create table if not exists entries (
  id integer primary key autoincrement,
  title string not null,
  text string not null
);
create table if not users entries (
  id integer primary key autoincrement,
  user string not null,
  password string not null
);
';
$dbh->do($schema) or die $dbh->errstr;
}

1;