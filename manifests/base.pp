class exim::base {
  package{'exim':
    ensure => installed,
  }

  service{exim:
    ensure => running,
    enable => true,
    hasstatus => true,
    require => Package[exim],
  }

  file{
    '/etc/exim/exim.conf':
      source => [ "puppet:///modules/site_exim/${::fqdn}/exim.conf",
                  "puppet:///modules/site_exim/${exim::component_type}/exim.conf",
                  "puppet:///modules/site_exim/${exim::component_cluster}/exim.conf",
                  "puppet:///modules/site_exim/exim.conf",
                  "puppet:///modules/exim/exim.conf" ],
      require => Package['exim'],
      notify => Service['exim'],
      owner => root, group => mail, mode => 0640;
    '/etc/exim/conf.d':
      ensure => directory,
      recurse => true,
      purge => true,
      force => true,
      require => Package['exim'],
      notify => Service['exim'],
      owner => root, group => mail, mode => 0640;
  }
}
