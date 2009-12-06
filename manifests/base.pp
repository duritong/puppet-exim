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

    file{'/etc/exim/exim.conf':
        source => [ "puppet://$server/modules/site-exim/${fqdn}/exim.conf",
                    "puppet://$server/modules/site-exim/exim.conf",
                    "puppet://$server/modules/exim/exim.conf" ],
        require => Package['exim'],
        notify => Service['exim'],
        owner => root, group => mail, mode => 0640;
    }
    file{'/etc/exim/conf.d':
      source => [ "puppet://$server/modules/site-exim/${fqdn}/conf.d",
                  "puppet://$server/modules/site-exim/conf.d",
                  "puppet://$server/modules/common/empty" ],
      ensure => directory,
      require => Package['exim'],
      notify => Service['exim'],
      owner => root, group => mail, mode => 0640;
    }
}
