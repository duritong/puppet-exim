class exim::sql::pgsql {
  case $::operatingsystem {
    'debian': { include exim::debian::heavy }
    default: {
      package{'exim-pgsql':
        ensure => present,
      }
    }
  }
}
