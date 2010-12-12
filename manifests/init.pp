# modules/exim/manifests/init.pp - manage exim stuff
# Copyright (C) 2007 admin@immerda.ch
#

class exim(
  $pgsql = false,
  $mysql = false,
  $ports = [ '25', '465', '587' ],
  $munin_checks = true,
  $nagios_checks = {
    '25' => 'tls',
    '465' => 'ssl',
    '587' => 'tls',
    'cert_days' => '10',
    'hostname' => 'fqdn'
  },
  $manage_shorewall = true
){
  case $operatingsystem {
    gentoo: { include exim::gentoo }
    default: { include exim::base }
  }

  if $exim::pgsql {
    include exim::sql::pgsql
  }
  if $exim::mysql {
    include exim::sql::mysql
  }

  if $exim::munin_checks {
    include exim::munin
  }

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
    if $nagios_checks['hostname'] == 'fqdn' {
      $host_to_check = $fqdn
    } else {
      $host_to_check = $fqdn
    }
    exim::nagios{$ports:
      checks => $nagios_checks,
      cert_days => $nagios_checks['cert_days'],
      host => $host_to_check
    }
  }
}
