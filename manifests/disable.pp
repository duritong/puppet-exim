class exim::disable {
  case $::kernel {
    linux: { include exim::disable::base }
  }
  if hiera('use_munin',false) {
    include ::exim::munin::disable
  }
}
