package Users;
use MyAppDB;

sub new { bless {}, shift }

sub isuser{
  my ($c, $username) = @_;
 # my $db=MyAppDB->new;
  my $dbh=MyAppDB->getcon();
  my $sql = "select * from users where name=\'$username\' limit 1";
  my $sth = $dbh->prepare($sql) or die $dbh->errstr;
     $sth->execute or die $sth->errstr;
  if (my @row = $sth->fetchrow_array()){
	MyAppDB->putcon();
	return 1 ;
	}
	return undef;
}
1;