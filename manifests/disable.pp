class exim::disable {
  case $::kernel {
    linux: { include exim::disable::base }
  }
}
