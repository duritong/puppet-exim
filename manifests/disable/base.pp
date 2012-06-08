class exim::disable::base {
  package{'exim':
    ensure => absent,
  }

  file{
    [ '/etc/exim/exim.conf',
      '/etc/exim/conf.d' ]:
      ensure => absent,
      purge => true,
      force => true,
      recurse => true,
  }

  service{'exim':
    enable => false,
    ensure => stopped,
    hasstatus => false,
  }
}
