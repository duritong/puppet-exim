class exim::debian::heavy inherits exim::debian::light {
  Package['exim-daemon-light']{
    ensure => absent,
  }
  
  package{'exim-daemon-heavy':
    ensure => present,
    before => Service['exim'],
  }
}