-- Remove conflicting tables
DROP TABLE IF EXISTS agents CASCADE;
DROP TABLE IF EXISTS apartments CASCADE;
DROP TABLE IF EXISTS cities CASCADE;
DROP TABLE IF EXISTS countries CASCADE;
DROP TABLE IF EXISTS enlisted_in CASCADE;
DROP TABLE IF EXISTS has_a_mark CASCADE;
DROP TABLE IF EXISTS lives_in CASCADE;
DROP TABLE IF EXISTS pets CASCADE;
DROP TABLE IF EXISTS special_appearance_marks CASCADE;
DROP TABLE IF EXISTS spy_agencies CASCADE;
DROP TABLE IF EXISTS ways_to_make_pressure CASCADE;
-- End of removing

CREATE TABLE agents (
    agents_id SERIAL NOT NULL,
    country_name VARCHAR(256) NOT NULL,
    real_name VARCHAR(256) NOT NULL,
    fake_name1 VARCHAR(256) NOT NULL,
    fake_name2 VARCHAR(256) NOT NULL,
    calling_sign VARCHAR(256) NOT NULL,
    language VARCHAR(256) NOT NULL,
    date_of_birth DATE NOT NULL
);
ALTER TABLE agents ADD CONSTRAINT pk_agents PRIMARY KEY (agents_id);

CREATE TABLE apartments (
    apartment_id SERIAL NOT NULL,
    name VARCHAR(256) NOT NULL,
    location VARCHAR(256) NOT NULL
);
ALTER TABLE apartments ADD CONSTRAINT pk_apartments PRIMARY KEY (apartment_id);
ALTER TABLE apartments ADD CONSTRAINT uc_apartments_location UNIQUE (location);

CREATE TABLE cities (
    city_name VARCHAR(256) NOT NULL,
    country_name VARCHAR(256) NOT NULL
);
ALTER TABLE cities ADD CONSTRAINT pk_cities PRIMARY KEY (city_name, country_name);

CREATE TABLE countries (
    country_name VARCHAR(256) NOT NULL,
    capital VARCHAR(256) NOT NULL
);
ALTER TABLE countries ADD CONSTRAINT pk_countries PRIMARY KEY (country_name);
ALTER TABLE countries ADD CONSTRAINT uc_countries_capital UNIQUE (capital);

-- Warning: Missing primary key. It is recommended to explicitly define a primary key.
CREATE TABLE enlisted_in (
    agents_id INTEGER NOT NULL,
    agency_id INTEGER NOT NULL,
    enlisted_from DATE NOT NULL,
    enlisted_until DATE NOT NULL
);

CREATE TABLE has_a_mark (
    agents_id INTEGER NOT NULL,
    mark_id INTEGER NOT NULL
);
ALTER TABLE has_a_mark ADD CONSTRAINT pk_has_a_mark PRIMARY KEY (agents_id, mark_id);

CREATE TABLE lives_in (
    agents_id INTEGER NOT NULL,
    apartment_id INTEGER NOT NULL,
    lives_from DATE NOT NULL,
    lives_until DATE NOT NULL
);
ALTER TABLE lives_in ADD CONSTRAINT pk_lives_in PRIMARY KEY (agents_id, apartment_id);

CREATE TABLE pets (
    pets_id SERIAL NOT NULL,
    agents_id INTEGER NOT NULL,
    species VARCHAR(256) NOT NULL,
    breed VARCHAR(256) NOT NULL
);
ALTER TABLE pets ADD CONSTRAINT pk_pets PRIMARY KEY (pets_id);

CREATE TABLE special_appearance_marks (
    mark_id SERIAL NOT NULL,
    mark VARCHAR(256) NOT NULL,
    body_part VARCHAR(256) NOT NULL
);
ALTER TABLE special_appearance_marks ADD CONSTRAINT pk_special_appearance_marks PRIMARY KEY (mark_id);
ALTER TABLE special_appearance_marks ADD CONSTRAINT uc_special_appearance_marks_bod UNIQUE (body_part);

CREATE TABLE spy_agencies (
    agency_id SERIAL NOT NULL,
    name VARCHAR(256) NOT NULL
);
ALTER TABLE spy_agencies ADD CONSTRAINT pk_spy_agencies PRIMARY KEY (agency_id);

CREATE TABLE ways_to_make_pressure (
    ways_id SERIAL NOT NULL,
    agents_id INTEGER NOT NULL,
    type VARCHAR(256) NOT NULL
);
ALTER TABLE ways_to_make_pressure ADD CONSTRAINT pk_ways_to_make_pressure PRIMARY KEY (ways_id);

ALTER TABLE agents ADD CONSTRAINT fk_agents_countries FOREIGN KEY (country_name) REFERENCES countries (country_name) ON DELETE CASCADE;

ALTER TABLE cities ADD CONSTRAINT fk_cities_countries FOREIGN KEY (country_name) REFERENCES countries (country_name) ON DELETE CASCADE;

ALTER TABLE enlisted_in ADD CONSTRAINT fk_enlisted_in_agents FOREIGN KEY (agents_id) REFERENCES agents (agents_id) ON DELETE CASCADE;
ALTER TABLE enlisted_in ADD CONSTRAINT fk_enlisted_in_spy_agencies FOREIGN KEY (agency_id) REFERENCES spy_agencies (agency_id) ON DELETE CASCADE;

ALTER TABLE has_a_mark ADD CONSTRAINT fk_has_a_mark_agents FOREIGN KEY (agents_id) REFERENCES agents (agents_id) ON DELETE CASCADE;
ALTER TABLE has_a_mark ADD CONSTRAINT fk_has_a_mark_special_appearanc FOREIGN KEY (mark_id) REFERENCES special_appearance_marks (mark_id) ON DELETE CASCADE;

ALTER TABLE lives_in ADD CONSTRAINT fk_lives_in_agents FOREIGN KEY (agents_id) REFERENCES agents (agents_id) ON DELETE CASCADE;
ALTER TABLE lives_in ADD CONSTRAINT fk_lives_in_apartments FOREIGN KEY (apartment_id) REFERENCES apartments (apartment_id) ON DELETE CASCADE;

ALTER TABLE pets ADD CONSTRAINT fk_pets_agents FOREIGN KEY (agents_id) REFERENCES agents (agents_id) ON DELETE CASCADE;

ALTER TABLE ways_to_make_pressure ADD CONSTRAINT fk_ways_to_make_pressure_agents FOREIGN KEY (agents_id) REFERENCES agents (agents_id) ON DELETE CASCADE;

