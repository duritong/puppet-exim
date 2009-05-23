class exim::munin {
  file{'/var/lib/munin/plugin-state/exim_mailstats':
    ensure => present,
    replace => false,
    require => Package['exim'],
    owner => nobody, group => exim, mode => 0640;
  }

  munin::plugin{
    'exim_mailstats':
      config => 'group exim';
    'exim_mailqueue':
      config => 'group exim';
  }
}
