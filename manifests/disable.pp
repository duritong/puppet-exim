class exim::disable {
    case $kernel {
        linux: { include exim::disable::base }
    }
    if $use_munin {
        include ::exim::munin::disable
    }
}
