# disable exim
class exim::disable {
  case $::osfamily {
    'Debian': { include ::exim::disable::debian }
    default: { include ::exim::disable::base }
  }
}
