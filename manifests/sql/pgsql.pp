# a postgres
class exim::sql::pgsql {
  case $::operatingsystem {
    'Debian': { include exim::debian::heavy }
    default: {
      package{'exim-pgsql':
        ensure => present,
      }
    }
  }
  if $exim::manage_firewall {
    include firewall::rules::out::postgres
  }
}
