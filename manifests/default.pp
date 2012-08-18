class exim::default {
  case $::operatingsystem {
    centos: {  include exim::default::centos }
    default: { fail("not yet able to set exim as default mta on ${::operatingsystem}") }
  }
}
