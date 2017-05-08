# manage a config snippet
define exim::config_snippet(
  $content = 'absent',
  $source  = 'absent',
){
  if $::operatingsystem in ['Debian'] {
    $group = 'Debian-exim'
    $fpath = "/etc/exim4/conf.d/${name}"
  } else {
    $group = 'exim'
    $fpath = "/etc/exim/conf.d/${name}"
  }

  file{$fpath:
    require => Package['exim'],
    notify  => Service['exim'],
    owner   => root,
    group   => $group,
    mode    => '0640';
  }
  if ($content == 'absent') {
    if $source == 'absent' {
      $real_source = [ "puppet:///modules/${exim::site_source}/conf.d/${::fqdn}/${name}",
                "puppet:///modules/${exim::site_source}/conf.d/${exim::component_type}/${name}",
                "puppet:///modules/${exim::site_source}/conf.d/${exim::component_cluster}/${name}",
                "puppet:///modules/${exim::site_source}/conf.d/${name}" ]
    } else {
      $real_source = $source
    }
    File[$fpath]{
      source => $real_source,
    }
  } else {
    File[$fpath]{
      content => $content,
    }
  }
}
