class exim::gentoo inherits exim::base {
  Package[exim]{
    category => 'mail-mta',
  }

  #conf.d file if needed
  Service[exim]{
    require +> File["/etc/conf.d/exim"],
  }
  file { "/etc/conf.d/exim":
    owner => "root",
    group => "0",
    mode  => 644,
    ensure => present,
    source => [
      "puppet:///modules/site_exim/conf.d/${::fqdn}/exim",
      "puppet:///modules/site_exim/conf.d/exim",
      "puppet:///modules/exim/conf.d/exim"
    ]
  }
}
