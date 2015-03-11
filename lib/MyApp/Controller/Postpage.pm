package MyApp::Controller::Postpage;
use Mojo::Base 'Mojolicious::Controller';

sub login {
  my $self = shift;
  my $aurl=$self->req->headers->referrer;
  $aurl=~s/http.+\//\//;
  if ($self->session->{name}){
  $self->render(msg => $aurl);
  } else {
	my $username=$self->param('username');
	my $password=$self->param('password');
	my $dbh = $self->AppDB->getcon();
    my $sql = "select * from users where name=\'$username\' and password=\'$password\' limit 1";
	#print $sql;
    my $sth = $dbh->prepare($sql) or die $dbh->errstr;
       $sth->execute or die $sth->errstr;
	  if (my @row = $sth->fetchrow_array()){
	  $self->session->{name}=$username;
	  $self->render(msg => $aurl);
	  } else {
	  $self->render(msg => $aurl);
	  } 
	$self->AppDB->putcon($dbh);  
}
}

sub publish{
    my $self = shift;
    my $dbh = $self->AppDB->getcon();
    my $sql = 'insert into entries (title, text,author) values (?, ?,?)';
    my $sth = $dbh->prepare($sql) or die $dbh->errstr;
    $sth->execute($self->param('title'), $self->param('text'),$self->session->{name})or die $sth->errstr;
	$self->AppDB->putcon($dbh);  
}

sub register{
	my $self = shift;
	my $username=$self->param('username');
	my $password=$self->param('password');
	if ($self->users->isuser($username)){
	$self->render(msg => '账号已存在');
	} else {
	my $dbh = $self->AppDB->getcon();
    my $sql = 'insert into users (name, password) values (?, ?)';
    my $sth = $dbh->prepare($sql) or die $dbh->errstr;
    $sth->execute($self->param('username'), $self->param('password'))or die $sth->errstr;
	$self->render(msg => '注册成功');
	$self->AppDB->putcon($dbh); 
	}
	
}

sub del{
	my $self = shift;
	
}
1;









