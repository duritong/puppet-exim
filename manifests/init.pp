# modules/exim/manifests/init.pp - manage exim stuff
# Copyright (C) 2007 admin@immerda.ch
#

class exim {
  case $operatingsystem {
    gentoo: { include exim::gentoo }
    default: { include exim::base }
  }

  if $exim_sql_pgsql or $exim_sql_mysql {
    include exim::sql
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
