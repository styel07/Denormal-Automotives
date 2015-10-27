-- Create a query to generate the tables needed to accomplish your normalized schema, including any primary and foreign key constraints. Logical renaming of columns is allowed.

DROP TABLE IF EXISTS normalized_cars;
DROP TABLE IF EXISTS make;
DROP TABLE IF EXISTS model;
DROP TABLE IF EXISTS year;

CREATE TABLE make (
  id serial PRIMARY KEY,
  company_name character varying(125),
  company_code character varying(125)
);

CREATE TABLE model (
  id serial PRIMARY KEY,
  model_name character varying(125),
  model_code character varying(125)
);

CREATE TABLE year (
  id serial PRIMARY KEY,
  year integer
);

CREATE TABLE normalized_cars (
  id serial PRIMARY KEY,
  make_id INTEGER REFERENCES make(id) NOT NULL,
  model_id INTEGER REFERENCES model(id) NOT NULL,
  year_id INTEGER REFERENCES year(id) NOT NULL
);


-- how to query data from other tables and insert it into different tables posgres

INSERT INTO make (company_code, company_name)
  SELECT  DISTINCT
  make_code,
  make_title
  FROM car_models;

INSERT INTO model (model_name, model_code)
  SELECT  DISTINCT
  model_code,
  model_title

  FROM car_models;

INSERT INTO year (year)
  SELECT DISTINCT year
  FROM car_models;

-- do 3x: ALTER TABLE car_models ... SYNTAX TO ADD COLUMN FOR: make_id, model_id, year_id
-- ALTER TABLE ADD id

INSERT INTO normalized_cars (make_id)
SELECT make.id
INNER JOIN make
ON (make.company_name = normalized_cars.make_title AND make.company_code = normalized_cars.make_code);

INSERT INTO normalized_cars (model_id)
SELECT model_id
INNER JOIN model
ON (model.model_name = normalized_cars.model_title AND model.model_name = normalized_cars.model_code);

INSERT INTO normalized_cars (year_id)
SELECT year_id
INNER JOIN year
ON (year.year_id = year.year);

-- ALTER TABLE DROP make_code,

-- do 4x: ALTER TABLE car_models .... SYNTAX TO DELETE COLUMNS FOR: make_code, make_title, model_code, model_title


-- In normal.sql Create a query to get a list of all make_title values in the car_models table. (should have 71 results)
-- SELECT DISTINCT make_title
-- FROM car_models;
-- INNER JOIN normalized_cars
-- on normalized_cars.id = make.id;

-- In normal.sql Create a query to list all model_title values where the make_code is 'VOLKS' (should have 27 results)
-- SELECT DISTINCT model_name
-- FROM normalized_cars
-- WHERE make_code = 'VOLKS';

-- In normal.sql Create a query to list all make_code, model_code, model_title, and year from car_models where the make_code is 'LAM' (should have 136 rows)

-- In normal.sql Create a query to list all fields from all car_models in years between 2010 and 2015 (should have 7884 rows)

-- select distinct car_model.model_title
-- from normalized_cars
-- inner join make
-- on normalized_cars.make_id = make.id
-- inner join normalized_cars
-- on normalized_cars.model_id = model.id
-- where normalized_cars.make_code = 'VOLKS';

-- select distinct make.make_code, model.model_code, model.model_name, year.year
-- from normalized_cars
-- inner join make
-- on make_id = make.id
-- inner join model
-- on model_id = model.id
-- inner join year
-- on year_id = year.id
-- where make.make_code = 'LAM';

-- write again in alias

-- SELECT DISTINCT cm.make_code AS MAKE, cd.model_code AS MODEL, cd.model_name AS NAME, cy.year AS YEAR
-- FROM normalized_cars AS n
-- INNER JOIN makes cm
-- on n.make_id = cm.id
-- INNER JOIN model AS cd
-- on n.model_id = cd.id
-- INNER JOIN year AS cy
-- on n.year_id = cy.id

-- select car_models.model_code
-- from normalized_cars n
-- inner join model cd
-- on cd.model_id = cd.id
-- inner join year year cy
-- on n.model_id = cy.id
-- WHERE year BETWEEN 2010 AND 2015;