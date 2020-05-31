--------------------------------------------------------------------------------- 
-- DEMO 0 --
-- 1- Create and populate worldregions database
---------------------------------------------------------------------------------
-- Create database
CREATE DATABASE WorldRegions;
ALTER DATABASE WorldRegions OWNER TO postgres;
SET SEARCH_PATH TO worldregions;

-- Create sequence for regions table
CREATE SEQUENCE regions_seq;

-- Create regions table
CREATE TABLE regions(
	region_id int DEFAULT NEXTVAL ('regions_seq') NOT NULL,
	region_name varchar(25) NULL,
PRIMARY KEY (region_id) 
);

-- Load data into regions table
INSERT INTO regions (region_name) VALUES ('Europe');
INSERT INTO regions (region_name) VALUES ('Americas');
INSERT INTO regions (region_name) VALUES ('Asia');
INSERT INTO regions (region_name) VALUES ('Middle East and Africa');

-- Check data in regions table
SELECT * FROM regions;
 
 -- Create countries table
CREATE TABLE countries(
	country_id char(2) NOT NULL,
	country_name varchar(40) NULL,
	region_id int NOT NULL,
PRIMARY KEY (country_id) 
);
 
 -- Load data into countries table
INSERT INTO countries (country_id, country_name, region_id) VALUES ('AR','Argentina', 2);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('AU','Australia', 3);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('BE','Belgium', 1);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('BR','Brazil', 2);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('CA','Canada', 2);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('CH','Switzerland', 1);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('CN','China', 3);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('DE','Germany', 1);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('DK','Denmark', 1);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('EG','Egypt', 4);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('FR','France', 1);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('HK','HongKong', 3);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('IL','Israel', 4);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('IN','India', 3);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('IT','Italy', 1);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('JP','Japan', 3);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('KW','Kuwait', 4);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('MX','Mexico', 2);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('NG','Nigeria', 4);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('NL','Netherlands', 1);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('SG','Singapore', 3);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('UK','United Kingdom', 1);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('US','United States of America', 2);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('ZM','Zambia', 4);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('ZW','Zimbabwe', 4);

-- Check data in countries table
SELECT * FROM countries;

-- Check data from both tables
SELECT
    a.country_name country, 
    b.region_name region 
FROM 
    countries a 
    INNER JOIN regions b ON a.region_id = b.region_id;

-- Create view for countries by region
CREATE VIEW vw_country_region AS 
    SELECT
        a.country_name country, 
        b.region_name region 
    FROM 
        countries a 
        INNER JOIN regions b ON a.region_id = b.region_id;

-- Check data retrieved by view
SELECT * FROM vw_country_region;