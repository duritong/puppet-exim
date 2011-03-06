class exim::greylist {
  case $operatingsystem {
    'debian': { include exim::debian::heavy }
    default: {
      package{'exim-greylist':
        ensure => present,
      }
    }
  }
}
