--------------------------------------------------------------------------------- 
-- DEMO 1 --
-- Query WorldRegions database
---------------------------------------------------------------------------------

-- Check data in regions table
SELECT * FROM regions;

-- Check data in countries table
SELECT * FROM countries;

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