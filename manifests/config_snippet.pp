define exim::config_snippet($content = 'absent'){
  $group = $operatingsystem ? {
    'debian' => 'Debian-exim',
    default => 'exim'
  }
  
  file{"/etc/exim/conf.d/${name}":
    require => Package['exim'],
    notify => Service['exim'],
    owner => root, group => $group, mode => 0640;
  }
  if ($content=='absent'){
    File["/etc/exim/conf.d/${name}"]{
      source => [ "puppet:///modules/site-exim/conf.d/${fqdn}/${name}",
                "puppet:///modules/site-exim/conf.d/${exim_component_type}/${name}",
                "puppet:///modules/site-exim/conf.d/${exim_component_cluster}/${name}",
                "puppet:///modules/site-exim/conf.d/${name}" ],
    }
  } else {
    File["/etc/exim/conf.d/${name}"]{
      content => $content,
    }
  }
  case $operatingsystem {
    'debian': {
      File["/etc/exim/conf.d/${name}"]{
        path => "/etc/exim4/conf.d/${name}"
      }
    }
  }
}
