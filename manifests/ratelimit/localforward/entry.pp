# add ratelimits for localforwards
define exim::ratelimit::localforward::entry(
  $key = $name,
  $ratelimit,
) {
  include ::exim::ratelimit::localforward
  concat::fragment{"localforward_ratelimit_${name}":
    target  => '/etc/exim/cdb/ratelimit_localforward.txt',
    content => "${key} ${ratelimit}\n",
  }
}
