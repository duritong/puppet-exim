# default debian installation
class exim::default {
  if $::osfamily == 'RedHat' {
    include exim::default::centos
  }
}
