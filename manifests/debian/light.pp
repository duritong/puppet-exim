class exim::debian::light {
  package{'exim4-daemon-light':
    ensure => present,
    before => Service['exim'],
  }
}