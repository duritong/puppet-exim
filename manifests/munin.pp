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
  $logdir = $operatingsystem ? {
    'debian' => '/var/log/exim4',
    default => '/var/log/exim'
  }
  $stats_group = $operatingsystem ? {
    'debian' => 'adm',
    default => 'exim'
  }
  munin::plugin{
    'exim_mailstats':
      config => "env.logdir ${logdir}
group ${stats_group}";
    'exim_mailqueue':
      config => "env.exim /usr/sbin/exim
group $group";
  }
}
