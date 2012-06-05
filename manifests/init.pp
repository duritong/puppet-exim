# modules/exim/manifests/init.pp - manage exim stuff
# Copyright (C) 2007 admin@immerda.ch
#

class exim(
  $pgsql = false,
  $mysql = false,
  $greylist = false,
  $ports = [ '25', '465', '587' ],
  $localonly = false,
  $munin_checks = true,
  $nagios_checks = {
    '25' => 'tls',
    '465' => 'ssl',
    '587' => 'tls',
    'cert_days' => '10',
    'dnsbl' => true,
    'hostname' => $fqdn,
  },
  $manage_shorewall = true,
  $component_type = hiera('exim_component_type',''),
  $component_cluster = hiera('exim_component_cluster',''),
  $type = ''
){
  case $::operatingsystem {
    gentoo: { include exim::gentoo }
    debian: { include exim::debian }
    default: { include exim::base }
  }

  if $exim::pgsql {
    include exim::sql::pgsql
  }
  if $exim::mysql {
    include exim::sql::mysql
  }
  if $exim::greylist {
    include exim::greylist
  }

  if $exim::munin_checks {
    include exim::munin
  }

  if $exim::manage_shorewall {
    include shorewall::rules::out::smtp
  }
  if !$localonly {
    if $exim::manage_shorewall {
      if array_include($ports,'25') {
        include shorewall::rules::smtp
      }
      if array_include($ports,'587') {
        include shorewall::rules::smtp_submission
      }
      if array_include($ports,'465') {
        include shorewall::rules::smtps
      }
    }

    if $exim::nagios_checks {
      exim::nagios{$ports:
        checks => $nagios_checks,
        cert_days => $exim::nagios_checks['cert_days'],
        host => $exim::nagios_checks['hostname']
      }
      nagios::service{"dnsbl_${fqdn}":
        check_command => "check_dnsbl!${exim::nagios_checks['hostname']}",
      }
      if $exim::nagios_checks['dnsbl'] != true {
        Nagios::Service["dnsbl_${fqdn}"]{
          ensure => 'absent',
        }
      }
    }
  }
}
