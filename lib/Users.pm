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
	MyAppDB->putcon($dbh);
	return 1 ;
	}
	MyAppDB->putcon($dbh);
	return undef;
}

sub isauthor{
  my($c,$id,$username)=@_;
  my $dbh=MyAppDB->getcon();
  my $sql = "select * from entries  where id=\'$id\' and author=\'$username\' limit 1";
  my $sth = $dbh->prepare($sql) or die $dbh->errstr;
     $sth->execute or die $sth->errstr;
       if (my @row = $sth->fetchrow_array()){
	       MyAppDB->putcon($dbh);
	       return 1 ;
	    }
	MyAppDB->putcon($dbh);	
	return undef;
}

sub delaricle{
	my($c,$id,$username)=@_;
	my $dbh = MyAppDB->getcon();
    my $sql = "delete from entries where id=\'$id\' and author=\'$username\'";
    my $sth = $dbh->prepare($sql) or die $dbh->errstr;
    $sth->execute or die $sth->errstr;
	MyAppDB->putcon($dbh); 
}

1;