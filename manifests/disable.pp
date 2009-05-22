# manifests/disable.pp
# disable exim

class exim::disable inherits exim {
    case $kernel {
        linux: { include exim::disable::base }
    }
    if $use_munin {
        include exim::munin::disable
    }
}

class exim::disable::base inherits exim::base {
    Package[exim]{
        ensure => absent,
    }

    File['/etc/exim/exim.conf']{
      source => undef,
      ensure => absent,
    }

    Service[exim]{
        enable => false,
        ensure => stopped,
    }
}
