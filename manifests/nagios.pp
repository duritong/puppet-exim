define exim::nagios(
  $checks,
  $cert_days,
  $host
){
  if $checks[$name] == 'tls' {
    @@nagios::smtp{
      "${hostname}_${$name}":
        host => $host,
        port => $name,
        cert_days => $cert_days ? {
          '' => 'absent',
          undef => 'absent',
          default => $cert_days
        };
    }
  } elsif $checks[$name] == 'ssl' {
    @@nagios::ssmtp{
      "${hostname}_${$name}":
        host => $host,
        port => $name,
        cert_days => $cert_days ? {
          '' => 'absent',
          undef => 'absent',
          default => $cert_days
        };
    }
  }
}
