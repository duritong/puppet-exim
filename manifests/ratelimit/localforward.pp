# ratelimit for localforwards
class exim::ratelimit::localforward(
  $default_ratelimit = '50',
){
  exim::config_snippet{'acl_ratelimit_localforward':
    source => 'puppet:///modules/exim/conf.d/acl_ratelimit_localforward',
  }

  concat{'/etc/exim/cdb/ratelimit_localforward.txt':
    owner => 'root',
    group => 'mail',
    mode  => '0640',
  }
  exim::ratelimit::localforward::entry{'default':
    key       => '*',
    ratelimit => $default_ratelimit,
  }
  exec{'generate_ratelimit_localforward':
    command     => 'cdb -m -c -t ratelimit_localforward.tmp ratelimit_localforward.cdb ratelimit_localforward.txt',
    cwd         => '/etc/exim/cdb',
    user        => 'mail',
    group       => 'mail',
    refreshonly => true,
    subscribe   => Concat['/etc/exim/cdb/ratelimit_localforward.txt'],
    before      => Service['exim'],
  }
}
