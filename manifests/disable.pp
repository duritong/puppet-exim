# disable exim
class exim::disable {
  case $::osfamily {
    'Debian': { include ::exim::disable::base }
    default: { include ::exim::disable::base }
  }
}
