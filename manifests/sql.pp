class exim::sql {
  if $exim_sql_mysql{
    include ::exim::sql::mysql
  }
  if $exim_sql_pgsql{
    include ::exim::sql::pgsql
  }
}
