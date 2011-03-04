class exim::sql::mysql {
  case $operatingsystem {
    'debian': { include exim::debian::heavy }
    default: {
      package{'exim-mysql':
        ensure => present,
      }
    }
  }
}
