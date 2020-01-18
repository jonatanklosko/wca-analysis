DROP TABLE IF EXISTS results;
CREATE TABLE results (
  id INTEGER,
  ranking INTEGER,
  person_id TEXT,
  competition_id TEXT,
  event_id TEXT,
  is_final INTEGER,
  attempt1 INTEGER,
  attempt2 INTEGER,
  attempt3 INTEGER,
  attempt4 INTEGER,
  attempt5 INTEGER,
  best INTEGER,
  average INTEGER,
  regional_single_record TEXT,
  regional_average_record TEXT
);

DROP TABLE IF EXISTS people;
CREATE TABLE people (
  id TEXT,
  name TEXT,
  country TEXT,
  gender TEXT
);

DROP TABLE IF EXISTS competitions;
CREATE TABLE competitions (
  id TEXT,
  name TEXT,
  country TEXT,
  city TEXT,
  start_date TEXT,
  end_date TEXT
);

DROP TABLE IF EXISTS events;
CREATE TABLE events (
  id TEXT,
  name TEXT,
  attempt_format TEXT
);
