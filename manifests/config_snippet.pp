define exim::config_snippet($content = 'absent'){
  file{"/etc/exim/conf.d/${name}":
    require => Packge['exim'],
    notify => Service['exim'],
    owner => root, group => mail, mode => 0640;
  }
  if ($content=='absent'){
    File["/etc/exim/conf.d/${name}"]{
      source => [ "puppet://$server/modules/site-exim/conf.d/${fqdn}/${name}",
                "puppet://$server/modules/site-exim/conf.d/${exim_component_cluster}/${name}",
                "puppet://$server/modules/site-exim/conf.d/${name}" ],
    }
  } else {
    File["/etc/exim/conf.d/${name}"]{
      content => $content,
    }
  }
}
