CREATE DATABASE PECL2;

CREATE SCHEMA temporal;

CREATE SCHEMA final;


CREATE TABLE IF NOT EXISTS temporal.persona(
    person_id           TEXT,
    person_sex          TEXT,
    person_lastname     TEXT,
    person_firstname    TEXT,
    person_phone        TEXT,
    person_address      TEXT,
    person_city         TEXT,
    person_state        TEXT,
    person_zip          TEXT,
    person_ssn          TEXT,
    person_dob          TEXT
);

CREATE TABLE IF NOT EXISTS temporal.accidentes(
    crash_date                      TEXT,
    crash_time                      TEXT,
    borough                         TEXT,
    zip_code                        TEXT,
    latitude                        TEXT,
    longitude                       TEXT,
    location                        TEXT,
    on_street_name                  TEXT,
    cross_street_name               TEXT,
    off_street_name                 TEXT,
    number_of_persons_injured       TEXT,
    number_of_persons_killed        TEXT,
    number_of_pedestrians_injured   TEXT,
    number_of_pedestrians_killed    TEXT,
    number_of_cyclist_injured       TEXT,
    number_of_cyclist_killed        TEXT,
    number_of_motorist_injured      TEXT,
    number_of_motorist_killed       TEXT,
    contributing_factor_vehicle1    TEXT,
    contributing_factor_vehicle2    TEXT,
    contributing_factor_vehicle3    TEXT,
    contributing_factor_vehicle4    TEXT,
    contributing_factor_vehicle5    TEXT,
    collision_id                    TEXT,
    vehicle_type_code_1             TEXT,
    vehicle_type_code_2             TEXT,
    vehicle_type_code_3             TEXT,
    vehicle_type_code_4             TEXT,
    vehicle_type_code_5             TEXT
);

CREATE TABLE IF NOT EXISTS temporal.vehiculos(
    vehicle_id          TEXT NOT NULL ,
    vehicle_year        TEXT,
    vehicle_type        TEXT,
    vehicle_model       TEXT,
    vehicle_make        TEXT
);

CREATE TABLE IF NOT EXISTS temporal.colision_personas(
    unique_id               TEXT,
    collision_id            TEXT,
    crash_date              TEXT,
    crash_time              TEXT,
    person_id               TEXT,
    person_type             TEXT,
    person_injury           TEXT,
    vehicle_id              TEXT,
    person_age              TEXT,
    ejection                TEXT,
    emotional_status        TEXT,
    bodily_injury           TEXT,
    position_in_vehicle     TEXT,
    safety_equipment        TEXT,
    ped_location            TEXT,
    ped_action              TEXT,
    complaint               TEXT,
    ped_role                TEXT,
    contributing_factor_1   TEXT,
    contributing_factor_2   TEXT,
    person_sex              TEXT
);


CREATE TABLE IF NOT EXISTS temporal.colision_vehiculos(
    unique_id                     TEXT,
    collision_id                  TEXT,
    crash_date                    TEXT,
    crash_time                    TEXT,
    vehicle_id                    TEXT,
    state_registration            TEXT,
    vehicle_type                  TEXT,
    vehicle_make                  TEXT,
    vehicle_model                 TEXT,
    vehicle_year                  TEXT,
    travel_direction              TEXT,
    vehicle_occupants             TEXT,
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

--INSERTAMOS LOS DATOS EN LAS TABLAS TEMPORALES
COPY temporal.vehiculos  FROM 'C:\datos\Vehicles.csv' DELIMITER ';' CSV HEADER NULL '';

COPY temporal.persona FROM 'C:\datos\personas2.csv' DELIMITER ';' CSV HEADER NULL '';

COPY temporal.accidentes FROM 'C:\datos\Collisions_Crashes_20241020.csv' DELIMITER ',' CSV HEADER NULL '';

COPY temporal.colision_personas FROM 'C:\datos\Collisions_Person_20241020.csv' DELIMITER ',' CSV HEADER NULL '';

COPY temporal.colision_vehiculos FROM 'C:\datos\Collisions_Vehicles_20241020.csv' DELIMITER ',' CSV HEADER NULL '';


--TABLAS FINALES

CREATE TYPE SEXO AS ENUM ('M', 'U', 'F');
CREATE TABLE IF NOT EXISTS final.persona(
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
    person_dob          DATE NOT NULL
);

CREATE TYPE COORDENADAS AS (
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION
);
CREATE TABLE IF NOT EXISTS final.accidentes(
    crash_date                      DATE NOT NULL ,
    crash_time                      TIME NOT NULL ,
    borough                         VARCHAR(20),
    zip_code                        VARCHAR(8),
    latitude                        DOUBLE PRECISION,
    longitude                       DOUBLE PRECISION,
    location                        COORDENADAS,
    on_street_name                  VARCHAR(50),
    cross_street_name               VARCHAR(50),
    off_street_name                 VARCHAR(50),
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
    collision_id                    INT NOT NULL
);

CREATE TABLE IF NOT EXISTS final.vehiculos(
    vehicle_id          VARCHAR(36) NOT NULL ,
    state_registration  char(2),
    vehicle_type        VARCHAR(40),
    vehicle_make        VARCHAR(40),
    vehicle_model       VARCHAR(20),
    vehicle_year        INT
);



CREATE TYPE TYPE_PERSON AS ENUM ('Occupant', 'Pedestrian', 'Bicyclist', 'Other Motorized');
CREATE TYPE INJURY_PERSON AS ENUM ('Unspecified', 'Injured', 'Killed');
CREATE TYPE EJECTION AS ENUM ('Not Ejected', 'Ejected', 'Partially Ejected', 'Trapped', 'Does Not Apply', 'Unknown');
CREATE TYPE EMOTIONAL_STATUS AS ENUM ('Conscious', 'Does Not Apply', 'Shock', 'Unknown', 'Semiconscious', 'Apparent Death', 'Incoherent', 'Unconscious');
CREATE TYPE PED_ROLE AS ENUM('Driver', 'Passenger', 'Notified Person', 'Registrant', 'Witness','Owner', 'Other', 'Pedestrian', 'In-Line Skater', 'Policy Holder');

CREATE TABLE IF NOT EXISTS final.colision_personas(
    unique_id               INT NOT NULL ,
    person_id               CHAR(32),
    person_type             TYPE_PERSON NOT NULL,
    person_injury           INJURY_PERSON NOT NULL,
    vehicle_id              INT,
    person_age              INT,
    ejection                EJECTION,
    emotional_status        EMOTIONAL_STATUS,
    bodily_injury           VARCHAR(30),
    position_in_vehicle     VARCHAR(100),
    safety_equipment        VARCHAR(40),
    ped_location            VARCHAR(100),
    ped_action              VARCHAR(40),
    complaint               VARCHAR(40),
    ped_role                PED_ROLE,
    contributing_factor_1   VARCHAR(50),
    contributing_factor_2   VARCHAR(50),
    person_sex              SEXO
);

CREATE TYPE DRIVER_LICENSE_STATUS AS ENUM('Licensed', 'Permit', 'Unlicensed');
CREATE TYPE PUBLIC_PROPERTY_DAMAGE AS ENUM('N', 'Y', 'Unspecified');

CREATE TABLE IF NOT EXISTS final.colision_vehiculos(
  vehicle_id                    VARCHAR(36) NOT NULL ,
  travel_direction              VARCHAR(50),
  vehicle_occupants             INT,
  driver_sex                    SEXO,
  driver_license_status         DRIVER_LICENSE_STATUS,
  driver_license_jurisdiction   VARCHAR(10),
  pre_crash                     VARCHAR(100),
  point_of_impact               VARCHAR(50),
  vehicle_damage                VARCHAR(50),
  vehicle_damage_1              VARCHAR(50),
  vehicle_damage_2              VARCHAR(50),
  vehicle_damage_3              VARCHAR(50),
  public_property_damage        PUBLIC_PROPERTY_DAMAGE,
  public_property_damage_type   VARCHAR(100),
  contributing_factor_1         VARCHAR(80),
  contributing_factor_2         VARCHAR(80)
);

--insertamos los datos de la tabla temporal a la final

INSERT INTO final.accidentes(crash_date, crash_time, borough, zip_code, latitude, longitude, location,
                             on_street_name, cross_street_name, off_street_name, number_of_persons_injured,
                             number_of_persons_killed, number_of_pedestrians_injured, number_of_pedestrians_killed,
                             number_of_cyclist_injured, number_of_cyclist_killed, number_of_motorist_injured,
                             number_of_motorist_killed, contributing_factor_vehicle1, contributing_factor_vehicle2,
                             contributing_factor_vehicle3, contributing_factor_vehicle4, contributing_factor_vehicle5, collision_id)
SELECT
    TO_DATE(temporal.accidentes.crash_date, 'MM/DD/YYYY'), --conversión a ese formato por no ser el estandar de SQL
    cast(temporal.accidentes.crash_time AS TIME WITHOUT TIME ZONE),
    cast(temporal.accidentes.borough AS VARCHAR(20)),
    cast(temporal.accidentes.zip_code AS VARCHAR(8)),
    cast(temporal.accidentes.latitude AS DOUBLE PRECISION),
    cast(temporal.accidentes.longitude AS DOUBLE PRECISION),
    ROW(
        cast(temporal.accidentes.latitude AS DOUBLE PRECISION),
        cast(temporal.accidentes.longitude AS DOUBLE PRECISION)
    )::COORDENADAS AS location, -- Creación del tipo compuesto COORDENADAS
    cast(temporal.accidentes.on_street_name AS VARCHAR(50)),
    cast(temporal.accidentes.cross_street_name AS VARCHAR(50)),
    cast(temporal.accidentes.off_street_name AS VARCHAR(50)),
    cast(temporal.accidentes.number_of_persons_injured AS INT),
    cast(temporal.accidentes.number_of_persons_killed AS INT),
    cast(temporal.accidentes.number_of_pedestrians_injured AS INT),
    cast(temporal.accidentes.number_of_pedestrians_killed AS INT),
    cast(temporal.accidentes.number_of_cyclist_injured AS INT),
    cast(temporal.accidentes.number_of_cyclist_killed AS INT),
    cast(temporal.accidentes.number_of_motorist_injured AS INT),
    cast(temporal.accidentes.number_of_motorist_killed AS INT),
    cast(temporal.accidentes.contributing_factor_vehicle1 AS VARCHAR(50)),
    cast(temporal.accidentes.contributing_factor_vehicle2 AS VARCHAR(50)),
    cast(temporal.accidentes.contributing_factor_vehicle3 AS VARCHAR(50)),
    cast(temporal.accidentes.contributing_factor_vehicle4 AS VARCHAR(50)),
    cast(temporal.accidentes.contributing_factor_vehicle5 AS VARCHAR(50)),
    cast(temporal.accidentes.collision_id AS INT)
FROM
    temporal.accidentes;

INSERT INTO final.persona(person_id, person_sex, person_lastname, person_firstname, person_phone, person_address,
                          person_city, person_state, person_zip, person_ssn, person_dob)
SELECT
    cast(temporal.persona.person_id AS CHAR(32)) AS person_id,
    cast(CASE
        WHEN temporal.persona.person_sex IN ('M', 'U', 'F') THEN temporal.persona.person_sex
    END AS SEXO) AS person_sex,
    cast(temporal.persona.person_lastname AS VARCHAR(20)),
    cast(temporal.persona.person_firstname AS VARCHAR(20)),
    cast(temporal.persona.person_phone AS VARCHAR(30)),
    cast(temporal.persona.person_address AS VARCHAR(100)),
    cast(temporal.persona.person_city AS VARCHAR(15)),
    cast(temporal.persona.person_state AS VARCHAR(15)),
    cast(NULLIF(temporal.persona.person_zip, '') AS INT),
    cast(temporal.persona.person_ssn AS CHAR(11)),
    cast(TO_DATE(temporal.persona.person_dob, 'YYYY-MM-DD') AS DATE)
FROM
    temporal.persona;

INSERT INTO final.vehiculos(vehicle_id, state_registration, vehicle_type, vehicle_make, vehicle_model, vehicle_year)
SELECT
    cast(temporal.vehiculos.vehicle_id AS VARCHAR(36)),
    cast(NULL AS CHAR(2)) AS state_registration,
    cast(temporal.vehiculos.vehicle_type AS VARCHAR(40)),
    cast(temporal.vehiculos.vehicle_make AS VARCHAR(40)),
    cast(temporal.vehiculos.vehicle_model AS VARCHAR(20)),
    cast(temporal.vehiculos.vehicle_year AS INT)
FROM
    temporal.vehiculos;

INSERT INTO final.colision_personas(unique_id, person_id, person_type, person_injury, vehicle_id, person_age, ejection,
                                    emotional_status, bodily_injury, position_in_vehicle, safety_equipment, ped_location,
                                    ped_action, complaint, ped_role, contributing_factor_1, contributing_factor_2,person_sex)
SELECT
    cast(temporal.colision_personas.unique_id AS INT),
    cast(temporal.colision_personas.person_id AS CHAR(32)),
    cast(temporal.colision_personas.person_type AS TYPE_PERSON),
    cast(temporal.colision_personas.person_injury AS INJURY_PERSON),
    cast(temporal.colision_personas.vehicle_id AS INT),
    cast(temporal.colision_personas.person_age AS INT),
    cast(temporal.colision_personas.ejection AS EJECTION),
    cast(temporal.colision_personas.emotional_status AS EMOTIONAL_STATUS),
    cast(temporal.colision_personas.bodily_injury AS VARCHAR(30)),
    cast(temporal.colision_personas.position_in_vehicle AS VARCHAR(100)),
    cast(temporal.colision_personas.safety_equipment AS VARCHAR(40)),
    cast(temporal.colision_personas.ped_location AS VARCHAR(100)),
    cast(temporal.colision_personas.ped_action AS VARCHAR(40)),
    cast(temporal.colision_personas.complaint AS VARCHAR(40)),
    cast(temporal.colision_personas.ped_role AS PED_ROLE),
    cast(temporal.colision_personas.contributing_factor_1 AS VARCHAR(50)),
    cast(temporal.colision_personas.contributing_factor_2 AS VARCHAR(50)),
    cast(temporal.colision_personas.person_sex AS SEXO)
FROM
    temporal.colision_personas;

INSERT INTO final.colision_vehiculos(vehicle_id, travel_direction, vehicle_occupants, driver_sex, driver_license_status,
                                     driver_license_jurisdiction, pre_crash, point_of_impact, vehicle_damage, vehicle_damage_1,
                                     vehicle_damage_2, vehicle_damage_3, public_property_damage, public_property_damage_type,
                                     contributing_factor_1, contributing_factor_2)
SELECT
    cast(temporal.colision_vehiculos.vehicle_id AS VARCHAR(36)),
    cast(temporal.colision_vehiculos.travel_direction AS VARCHAR(50)),
    cast(temporal.colision_vehiculos.vehicle_occupants AS INT),
    cast(temporal.colision_vehiculos.driver_sex AS SEXO),
    cast(temporal.colision_vehiculos.driver_license_status AS DRIVER_LICENSE_STATUS),
    cast(temporal.colision_vehiculos.driver_license_jurisdiction AS VARCHAR(10)),
    cast(temporal.colision_vehiculos.pre_crash AS VARCHAR(100)),
    cast(temporal.colision_vehiculos.point_of_impact AS VARCHAR(50)),
    cast(temporal.colision_vehiculos.vehicle_damage AS VARCHAR(50)),
    cast(temporal.colision_vehiculos.vehicle_damage_1 AS VARCHAR(50)),
    cast(temporal.colision_vehiculos.vehicle_damage_2 AS VARCHAR(50)),
    cast(temporal.colision_vehiculos.vehicle_damage_3 AS VARCHAR(50)),
    cast(temporal.colision_vehiculos.public_property_damage AS PUBLIC_PROPERTY_DAMAGE),
    cast(temporal.colision_vehiculos.public_property_damage_type AS VARCHAR(100)),
    cast(temporal.colision_vehiculos.contributing_factor_1 AS VARCHAR(50)),
    cast(temporal.colision_vehiculos.contributing_factor_2 AS VARCHAR(50))
FROM temporal.colision_vehiculos;
