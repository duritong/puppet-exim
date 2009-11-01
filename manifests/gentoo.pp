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
            "puppet://$server/modules/exim/conf.d/exim"
        ]
    }
}
