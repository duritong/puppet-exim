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
                    "puppet://$server/modules/site-exim/${exim_type}/exim.conf",
                    "puppet://$server/modules/site-exim/exim.conf",
                    "puppet://$server/modules/exim/exim.conf" ],
        require => Package['exim'],
        notify => Service['exim'],
        owner => root, group => mail, mode => 0640;
    }
}
