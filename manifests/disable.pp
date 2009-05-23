# manifests/disable.pp
# disable exim

class exim::disable inherits exim {
    case $kernel {
        linux: { include exim::disable::base }
    }
    if $use_munin {
        include ::exim::munin::disable
    }
}
