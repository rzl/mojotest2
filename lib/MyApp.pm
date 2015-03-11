package MyApp;
use Mojo::Base 'Mojolicious';
use MyAppDB;
use Users;


# This method will run once at server start
sub startup {
  my $self = shift;
  my $AppDB = MyAppDB->new;
  $self->helper(AppDB => sub { return $AppDB });
  my $users=Users->new;
  $self->helper(users => sub {return $users});
  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer');
  # Router
  my $r = $self->routes;
  unless  (-e "mojo.db") {
  print "not found database file .";
  $self->AppDB->initdata();
  }
  # Normal route to controller
  $r->get('/')->to('example#welcome');
  $r->get('/index')->to('example#index');
  $r->get('/publish')->to('example#publish');
  $r->post('/publish')->to('Postpage#publish');
  $r->get('/login')->to('example#login');
  $r->post('/login')->to('Postpage#login');
  $r->get('/logout')->to('example#logout');
  $r->get('/register')->to('example#register');
  $r->post('/register')->to('Postpage#register');
  $r->get('/del')->to('example#del');
}

1;
