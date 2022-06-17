# nagios checks
define exim::nagios(
  $checks,
  $cert_days,
  $host,
  Boolean $ip4_and_ip6 = ('ip6' in $facts['networking'] and $facts['networking']['ip6'] !~ /^fe80/),
){
  $real_cert_days = $cert_days ? {
    ''      => 'absent',
    undef   => 'absent',
    default => $cert_days,
  }
  if $checks[$name] == 'tls' {
    nagios::service::smtp{
      "${facts['networking']['hostname']}_${name}":
        host        => $host,
        port        => $name,
        cert_days   => $real_cert_days,
        ip4_and_ip6 => $ip4_and_ip6;
    }
  } elsif $checks[$name] == 'ssl' {
    nagios::service::ssmtp{
      "${facts['networking']['hostname']}_${name}":
        host        => $host,
        port        => $name,
        cert_days   => $real_cert_days,
        ip4_and_ip6 => $ip4_and_ip6;
    }
  }
}
