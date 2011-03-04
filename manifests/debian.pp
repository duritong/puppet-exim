class exim::debian inherits exim::base {
  Package['exim'] {
    name => 'exim4-base',
  }
  include exim::debian::light

  File['/etc/exim/exim.conf'] {
    path => '/etc/exim4/exim4.conf',
    group => 'Debian-exim',
  }
  File['/etc/exim/conf.d'] {
    path => '/etc/exim4/conf.d',
    group => 'Debian-exim',
  }
  Service['exim'] {
    name => 'exim4'
  }
}