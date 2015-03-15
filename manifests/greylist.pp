# install greylisting
class exim::greylist {
  case $::operatingsystem {
    'Debian': { include exim::debian::heavy }
    default: {
      package{'exim-greylist':
        ensure => present,
      }
    }
  }
}
