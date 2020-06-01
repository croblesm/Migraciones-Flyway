--------------------------------------------------------------------------------- 
-- DEMO 1 --
-- V2: Create structures
---------------------------------------------------------------------------------

-- Create sequence for regions table
CREATE SEQUENCE regions_seq;

-- Create regions table
CREATE TABLE regions (
	region_id int DEFAULT NEXTVAL ('regions_seq') NOT NULL,
	region_name varchar(32) NULL,
    PRIMARY KEY (region_id)
);

 -- Create countries table
CREATE TABLE countries (
	country_id char(2) NOT NULL,
	country_name varchar(64) NULL,
	region_id int NOT NULL,
    PRIMARY KEY (country_id),
    FOREIGN KEY (region_id) REFERENCES regions (id)
);