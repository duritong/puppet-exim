class exim::disable {
  case $::kernel {
    linux: { include exim::disable::base }
  }
  if $exim::manage_munin {
    include ::exim::munin::disable
  }
}
