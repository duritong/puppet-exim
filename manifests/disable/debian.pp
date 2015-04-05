# disable on debian
class exim::disable::debian inherits exim::disable::base {
  Service['exim']{
    hasstatus => false,
  }
}
