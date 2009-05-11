# modules/exim/manifests/init.pp - manage exim stuff
# Copyright (C) 2007 admin@immerda.ch
#

class exim {
    case $operatingsystem {
        gentoo: { include exim::gentoo }
        default: { include exim::base }
    }
}

class exim::base {
    package{'exim':
        ensure => installed,
    }

    service{exim:
        ensure => running,
        enable => true,
        #hasstatus => true, #fixme!
        require => Package[exim],
    }

    if $use_munin {
        include exim::munin
    }
}

class exim::gentoo inherits exim::base {
    Package[exim]{
        category => 'mail-mta',
    }

    #conf.d file if needed
    Service[exim]{
       require +> File["/etc/conf.d/exim"],
    }
    file { "/etc/conf.d/exim":
        owner => "root",
        group => "0",
        mode  => 644,
        ensure => present,
        source => [
            "puppet://$server/files/exim/conf.d/${fqdn}/exim",
            "puppet://$server/files/exim/conf.d/exim",
            "puppet://$server/exim/conf.d/exim"
        ]
    }
}
