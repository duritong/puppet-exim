# the full daemon
class exim::debian::heavy inherits exim::debian::light {
  Package['exim4-daemon-light']{
    ensure => absent,
  }

  package{'exim4-daemon-heavy':
    ensure => present,
    before => Service['exim'],
  }
}
