# manage the default mta
class exim::default::centos {
  alternatives::manage{
    'mta':
      target => '/usr/sbin/sendmail.exim',
      require => Service['exim'];
  }
}
