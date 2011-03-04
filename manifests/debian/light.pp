class exim::debian::light {
  package{'exim-daemon-light':
    ensure => present,
    before => Service['exim'],
  }
}