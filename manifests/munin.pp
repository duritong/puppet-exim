# setup munin monitoring for exim
class exim::munin {
  $group = $::operatingsystem ? {
    'debian'  => 'Debian-exim',
    default   => 'exim'
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
