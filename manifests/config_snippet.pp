define exim::config_snippet(){
  file{"/etc/exim/conf.d/${name}":
    source => [ "puppet://$server/modules/site-exim/${fqdn}/conf.d/${name}",
                "puppet://$server/modules/site-exim/conf.d/${name}" ],
    require => Packge['exim'],
    notify => Service['exim'],
    owner => root, group => mail, mode => 0640;
  }
}
