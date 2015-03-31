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
  if $exim::manage_shorewall {
    include shorewall::rules::out::postgres
  }
}
