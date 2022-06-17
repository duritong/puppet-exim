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
    '25'          => 'tls',
    '465'         => 'ssl',
    '587'         => 'tls',
    'cert_days'   => '10',
    'dnsbl'       => true,
    'hostname'    => $facts['networking']['fqdn'],
    'ip4_and_ip6' => ('ip6' in $facts['networking'] and $facts['networking']['ip6'] !~ /^fe80/),
  },
  $manage_firewall   = true,
  $component_type    = '',
  $component_cluster = '',
  $type              = '',
  $default_mta       = true,
  $site_source       = 'site_exim',
){
  case $facts['os']['name'] {
    'Gentoo': { include exim::gentoo }
    'Debian': { include exim::debian }
    default: { include exim::base }
  }

  if $pgsql {
    include exim::sql::pgsql
  }
  if $mysql {
    include exim::sql::mysql
  }
  if $greylist {
    include exim::greylist
  }

  if $manage_munin {
    include exim::munin
  }

  if $default_mta {
    include exim::default
  }

  if $manage_firewall {
    include firewall::rules::out::smtp
  }
  if !$localonly {
    if $manage_firewall {
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
        checks      => $nagios_checks,
        cert_days   => $nagios_checks['cert_days'],
        host        => $nagios_checks['hostname'],
        ip4_and_ip6 => $nagios_checks['ip4_and_ip6'];
      }
      if $nagios_checks['dnsbl'] == true {
        nagios::service{"dnsbl_${facts['networking']['fqdn']}":
          check_command => "check_dnsbl!${nagios_checks['hostname']}",
        }
      }
    }
  }
}
