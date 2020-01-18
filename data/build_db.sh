#!/bin/bash

# This script creates an SQLite database file as defined in schema.sql
# and feeds it with data from a local MySQL WCA databse.

cd "$(dirname "$0")"

if [ $# -eq 0 ]; then
  echo "Usage: $0 <local-mysql-wca-db-name>" >> /dev/stderr
  exit 1
fi

mysql_dbname=$1
sqlite_dbname="wca.db"

tsv_export_dir="mysql_tsv_export"
mkdir -p ${tsv_export_dir}

results_query="
SELECT
  id,
  pos ranking,
  personId person_id,
  competitionId competition_id,
  eventId event_id,
  roundTypeId IN ('c', 'f') is_final,
  value1 attempt_1,
  value2 attempt_2,
  value3 attempt_3,
  value4 attempt_4,
  value5 attempt_5,
  best,
  average,
  regionalSingleRecord regional_single_record,
  regionalAverageRecord regional_average_record
FROM Results
"
mysql $mysql_dbname -e "${results_query}" --batch --skip-column-names > $tsv_export_dir/results.tsv

people_query="
SELECT
  id,
  name,
  countryId country,
  gender
FROM Persons
WHERE subId = 1
"
mysql $mysql_dbname -e "${people_query}" --batch --skip-column-names > $tsv_export_dir/people.tsv

competitions_query="
SELECT
  id,
  name,
  countryId country,
  cityName city,
  start_date,
  end_date
FROM Competitions
"
mysql $mysql_dbname -e "${competitions_query}" --batch --skip-column-names > $tsv_export_dir/competitions.tsv

events_query="
SELECT
  id,
  name,
  format attempt_format
FROM Events
"
mysql $mysql_dbname -e "${events_query}" --batch --skip-column-names > $tsv_export_dir/events.tsv

sqlite3 $sqlite_dbname <<-EOF
.read schema.sql
.mode tabs
.import ${tsv_export_dir}/results.tsv results
.import ${tsv_export_dir}/people.tsv people
.import ${tsv_export_dir}/competitions.tsv competitions
.import ${tsv_export_dir}/events.tsv events
EOF

rm -rf mysql_tsv_export
