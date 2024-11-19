CREATE DATABASE PECL2;

CREATE TYPE SEXO AS ENUM ('M', 'U', 'F');

CREATE TABLE IF NOT EXISTS Persona(
    person_id           CHAR(32) NOT NULL,
    person_sex          SEXO,
    person_lastname     VARCHAR(20) NOT NULL,
    person_firstname    VARCHAR(20) NOT NULL,
    person_phone        VARCHAR(30) NOT NULL,
    person_address      VARCHAR(100) NOT NULL,
    person_city         VARCHAR(15) NOT NULL,
    person_state        VARCHAR(15) NOT NULL,
    person_zip          INT NOT NULL,
    person_ssn          CHAR(11) NOT NULL,
    person_dob          DATE NOT NULL,
    CONSTRAINT Persona_pk PRIMARY KEY (person_id)
);
SELECT person_dob FROM "personas2" WHERE  person_dob IS NULL;


CREATE TYPE COORDENADAS AS (
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION
);

CREATE TABLE IF NOT EXISTS Accidentes(
    collision_id                    INT NOT NULL ,
    crash_date                      DATE NOT NULL ,
    crash_time                      TIME NOT NULL ,
    borough                         VARCHAR(20),
    zip_code                        INT,
    latitude                        DOUBLE PRECISION,
    longitude                       DOUBLE PRECISION,
    location                        COORDENADAS,
    on_street_name                  VARCHAR(50),
    cross_street_name               VARCHAR(50),
    off_street_name                 VARCHAR(25),
    number_of_persons_injured       INT,
    number_of_persons_killed        INT,
    number_of_pedestrians_injured   INT,
    number_of_pedestrians_killed    INT,
    number_of_cyclist_injured       INT,
    number_of_cyclist_killed        INT,
    number_of_motorist_injured      INT,
    number_of_motorist_killed       INT,
    contributing_factor_vehicle1    VARCHAR(50),
    contributing_factor_vehicle2    VARCHAR(50),
    contributing_factor_vehicle3    VARCHAR(50),
    contributing_factor_vehicle4    VARCHAR(50),
    contributing_factor_vehicle5    VARCHAR(50),
    CONSTRAINT Accidentes_pk PRIMARY KEY (collision_id)
);



CREATE TABLE IF NOT EXISTS Vehiculos(
    vehicle_id          varchar(36) NOT NULL ,
    state_registration  char(2),
    vehicle_type        VARCHAR(40),
    vehicle_make        VARCHAR(40),
    vehicle_model       VARCHAR(20),
    vehicle_year        INT,
    CONSTRAINT Vehiculo_pk PRIMARY KEY (vehicle_id)
);


CREATE TYPE TYPE_PERSON AS ENUM ('Occupant', 'Pedestrian', 'Bicyclist', 'Other Motorized');
CREATE TYPE INJURY_PERSON AS ENUM ('Unspecified', 'Injured', 'Killed');
CREATE TYPE EJECTION AS ENUM ('Not Ejected', 'Ejected', 'Partially Ejected', 'Trapped', 'Does Not Apply', 'Unknown');
CREATE TYPE EMOTIONAL_STATUS AS ENUM ('Conscious', 'Does Not Apply', 'Shock', 'Unknown', 'Semiconscious', 'Apparent Death', 'Incoherent', 'Unconscious');
CREATE TYPE PED_ROLE AS ENUM('Driver', 'Passenger', 'Notified Person', 'Registrant', 'Witness','Owner', 'Other', 'Pedestrian', 'In-Line Skater', 'Policy Holder');

CREATE TABLE IF NOT EXISTS Colision_personas(
    unique_id               INT NOT NULL ,
    person_id               CHAR(32),
    person_type             TYPE_PERSON NOT NULL,
    person_injury           INJURY_PERSON NOT NULL,
    vehicle_id              INT,
    person_age              INT,
    ejection                EJECTION,
    emotional_status        EMOTIONAL_STATUS,
    bodily_injury           VARCHAR(40),
    position_in_vehicle     VARCHAR(100),
    safety_equipment        VARCHAR(40),
    ped_location            VARCHAR(100),
    ped_action              VARCHAR(40),
    complaint               VARCHAR(40),
    ped_role                PED_ROLE,
    contributing_factor_1   VARCHAR(50),
    contributing_factor_2   VARCHAR(50),
    person_sex              SEXO,
    CONSTRAINT Colision_personas_pk PRIMARY KEY (unique_id)
);


CREATE TABLE IF NOT EXISTS Colision_vehiculos(
  vehicle_id                    INT,
  travel_direction              TEXT,
  vehicle_occupants             SEXO,
  driver_sex                    TEXT,
  driver_license_status         TEXT,
  driver_license_jurisdiction   TEXT,
  pre_crash                     TEXT,
  point_of_impact               TEXT,
  vehicle_damage                TEXT,
  vehicle_damage_1              TEXT,
  vehicle_damage_2              TEXT,
  vehicle_damage_3              TEXT,
  public_property_damage        TEXT,
  public_property_damage_type   TEXT,
  contributing_factor_1         TEXT,
  contributing_factor_2         TEXT
);

