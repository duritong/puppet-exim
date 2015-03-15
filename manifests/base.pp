# base exim
class exim::base {
  package{'exim':
    ensure => installed,
  }

  file{
    '/etc/exim/exim.conf':
      source  => ["puppet:///modules/${exim::site_source}/${::fqdn}/exim.conf",
                  "puppet:///modules/${exim::site_source}/${exim::component_type}/exim.conf",
                  "puppet:///modules/${exim::site_source}/${exim::component_cluster}/exim.conf",
                  "puppet:///modules/${exim::site_source}/exim.conf",
                  'puppet:///modules/exim/exim.conf' ],
      require => Package['exim'],
      notify  => Service['exim'],
      owner   => root,
      group   => mail,
      mode    => '0640';
    '/etc/exim/conf.d':
      ensure  => directory,
      recurse => true,
      purge   => true,
      force   => true,
      require => Package['exim'],
      notify  => Service['exim'],
      owner   => root,
      group   => mail,
      mode    => '0640';
  }

  service{'exim':
    ensure => running,
    enable => true,
  }

}
