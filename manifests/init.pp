# modules/exim/manifests/init.pp - manage exim stuff
# Copyright (C) 2007 admin@immerda.ch
#

# manage an exim installation
class exim(
  $pgsql             = false,
  $mysql             = false,
  $greylist          = false,
  $ports             = [ '25', '465', '587' ],
  $localonly         = false,
  $manage_munin      = false,
  $nagios_checks     = {
    '25'        => 'tls',
    '465'       => 'ssl',
    '587'       => 'tls',
    'cert_days' => '10',
    'dnsbl'     => true,
    'hostname'  => $::fqdn,
  },
  $manage_firewall   = true,
  $component_type    = '',
  $component_cluster = '',
  $type              = '',
  $default_mta       = true,
  $site_source       = 'site_exim',
){
  case $::operatingsystem {
    'Gentoo': { include exim::gentoo }
    'Debian': { include exim::debian }
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

  if $exim::manage_munin {
    include exim::munin
  }

  if $exim::default_mta {
    include exim::default
  }

  if $exim::manage_firewall {
    include firewall::rules::out::smtp
  }
  if !$localonly {
    if $exim::manage_firewall {
      if '25' in $ports {
        include firewall::rules::smtp
      }
      if '587' in $ports {
        include firewall::rules::smtp_submission
      }
      if '465' in $ports {
        include firewall::rules::smtps
      }
    }

    if $exim::nagios_checks {
      exim::nagios{$ports:
        checks    => $nagios_checks,
        cert_days => $exim::nagios_checks['cert_days'],
        host      => $exim::nagios_checks['hostname']
      }
      nagios::service{"dnsbl_${::fqdn}":
        check_command => "check_dnsbl!${exim::nagios_checks['hostname']}",
      }
      if $exim::nagios_checks['dnsbl'] != true {
        Nagios::Service["dnsbl_${::fqdn}"]{
          ensure => 'absent',
        }
      }
    }
  }
}
