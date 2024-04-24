DROP TABLE IF EXISTS t_tomas_stveracek_project_SQL_secondary_final;

CREATE TABLE t_tomas_stveracek_project_SQL_secondary_final AS
SELECT
    c.country,
    c.capital_city,
    c.continent,
    c.region_in_world,
    e.year,
    e.GDP,
    e.gini,
    e.population,
    e.taxes
FROM 
	countries c
JOIN
	economies e ON c.country = e.country;

SELECT * FROM t_tomas_stveracek_project_SQL_secondary_final;	 

