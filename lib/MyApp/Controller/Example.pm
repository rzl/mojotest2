package MyApp::Controller::Example;
use Mojo::Base 'Mojolicious::Controller';

# This action will render a template
sub welcome {
  my $self = shift;

  # Render template "example/welcome.html.ep" with message
  $self->render(msg => 'Welcome to the Mojolicious real-time web framework!');
}

sub index {
    my $self = shift;
	my $db = $self->AppDB->connect_db();
    my $sql = 'select id, title, text,author from entries order by id desc';
    my $sth = $db->prepare($sql) or die $db->errstr;
       $sth->execute or die $sth->errstr;
	   $self->stash(entries=> $sth-> fetchall_arrayref);
	   $self->render();
	   $db->disconnect();
}

sub publish {
  my $self = shift;
  $self->render();
}

sub login {
  my $self = shift;

  $self->render();
}

sub logout{
	my $self=shift;
	$self->session->{name}='';
	$self->render();
}

1;
