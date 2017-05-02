DROP TABLE IF EXISTS favourites;
DROP TABLE IF EXISTS heroes;
DROP TABLE IF EXISTS players;

CREATE TABLE players(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  team VARCHAR(255)
);

CREATE TABLE heroes(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  description VARCHAR(255)
);

CREATE TABLE favourites(
  id SERIAL8 PRIMARY KEY,
  player_id INT8 REFERENCES players( id ) ON DELETE CASCADE,
  hero_id INT8 REFERENCES heroes( id ) ON DELETE CASCADE
);
