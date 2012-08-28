class exim::default {
  case $::operatingsystem {
    centos,redhat,fedora: {  include exim::default::centos }
  }
}
