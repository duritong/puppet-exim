class exim::munin::disable inherits exim::munin {
  File{'/var/lib/munin/plugin-state/exim_mailstats']{
    ensure => absent,
  }

  Munin::Plugin['exim_mailstats', 'exim_mailqueue']{
      ensure => 'absent',
  }
}
