# setup munin monitoring for exim
class exim::munin {
  $group = $::operatingsystem ? {
    'debian'  => 'Debian-exim',
    default   => 'exim'
  }
  file{'/var/lib/munin/plugin-state/exim_mailstats':
    ensure  => present,
    replace => false,
    require => Package['exim','munin-node'],
    owner   => nobody,
    group   => $group,
    mode    => '0640';
  }
  $logdir = '/var/log'
  $logfile = 'maillog'
  munin::plugin{
    'exim_mailstats':
      config  => "env.logdir ${logdir}
env.logname ${logfile}
user root";
    'exim_mailqueue':
      config  => "env.exim /usr/sbin/exim
group ${group}";
  }
}
