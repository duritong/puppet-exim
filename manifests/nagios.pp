# nagios checks
define exim::nagios(
  $checks,
  $cert_days,
  $host,
){
  $real_cert_days = $cert_days ? {
    ''      => 'absent',
    undef   => 'absent',
    default => $cert_days,
  }
  if $checks[$name] == 'tls' {
    nagios::service::smtp{
      "${::hostname}_${name}":
        host      => $host,
        port      => $name,
        cert_days => $real_cert_days;
    }
  } elsif $checks[$name] == 'ssl' {
    nagios::service::ssmtp{
      "${::hostname}_${name}":
        host      => $host,
        port      => $name,
        cert_days => $real_cert_days;
    }
  }
}
