# a mysql
class exim::sql::mysql {
  case $::operatingsystem {
    'Debian': { include exim::debian::heavy }
    default: {
      package{'exim-mysql':
        ensure => present,
      }
    }
  }
  if $exim::manage_firewall {
    include firewall::rules::out::mysql
  }
}
