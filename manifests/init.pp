# modules/exim/manifests/init.pp - manage exim stuff
# Copyright (C) 2007 admin@immerda.ch
#

class exim(
  $exim_pgsql = false,
  $exim_mysql = false
){
  case $operatingsystem {
    gentoo: { include exim::gentoo }
    default: { include exim::base }
  }

  if $exim_pgsql {
    include exim::sql::pgsql
  }
  if $exim_mysql {
    include exim::sql::mysql
  }

  if $use_munin {
    include exim::munin
  }
  if $use_shorewall {
    include shorewall::rules::smtp
    include shorewall::rules::smtp_submission
    include shorewall::rules::smtps
  }
}
