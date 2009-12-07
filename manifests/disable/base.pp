class exim::disable::base inherits exim::base {
    Package[exim]{
        ensure => absent,
    }

    File['/etc/exim/exim.conf']{
      source => undef,
      ensure => absent,
    }

    File['/etc/exim/conf.d']{
      source => undef,
      ensure => absent,
    }

    Service[exim]{
        enable => false,
        ensure => stopped,
        hasstatus => false,
    }
}
