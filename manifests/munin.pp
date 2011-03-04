class exim::munin {
  $group = $operatingsystem ? {
    'debian' => 'Debian-exim',
    default => 'exim'
  }
  file{'/var/lib/munin/plugin-state/exim_mailstats':
    ensure => present,
    replace => false,
    require => Package['exim'],
    owner => nobody, group => $group, mode => 0640;
  }

  munin::plugin{
    'exim_mailstats':
      config => "group ${group}";
    'exim_mailqueue':
      config => "env.exim /usr/sbin/exim
group exim";
  }
}
