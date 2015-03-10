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
	my $db = $self->AppDB->connect_db();
    my $sql = "select * from users where name=\'$username\' and password=\'$password\' limit 1";
	#print $sql;
    my $sth = $db->prepare($sql) or die $db->errstr;
       $sth->execute or die $sth->errstr;
	  if (my @row = $sth->fetchrow_array()){
	  $self->session->{name}=$username;
	  $self->render(msg => $aurl);
	  } else {
	  $self->render(msg => $aurl);
	  } 
}
}

sub publish{
    my $self = shift;
    my $db = $self->AppDB->connect_db();
    my $sql = 'insert into entries (title, text) values (?, ?)';
    my $sth = $db->prepare($sql) or die $db->errstr;
    $sth->execute($self->param('title'), $self->param('text'))or die $sth->errstr;
}

sub register{
	my $self = shift;
	my $username=$self->param('username');
	my $password=$self->param('password');
	if ($self->users->isuser($username)){
	$self->render(msg => '账号已存在');
	} else {
	my $db = $self->AppDB->connect_db();
    my $sql = 'insert into users (name, password) values (?, ?)';
    my $sth = $db->prepare($sql) or die $db->errstr;
    $sth->execute($self->param('username'), $self->param('password'))or die $sth->errstr;
	$self->render(msg => '注册成功');
	}
	
}
1;









