/*
 *  Výzkumná otázka 1:
 *  Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
 */

/*
 * Dotaz zkoumá meziroční změny průmerných mezd ve vybraných odvětvích.
 * Porovnává průměrné mzdy mezi aktuálním a předchozím rokem a klasifikuje změnu trendu - růst nebo pokles.
 */

-- Hlavní dotaz, který zahrnuje výsledky srovnání aktuálního a předchozího roku
SELECT
	current.industry_branch,
	current.year AS current_year,
	previous.year AS previous_year,
	current.avg_annual_wage,
	previous.avg_annual_wage AS previous_year_avg_wage,
	current.avg_annual_wage - previous.avg_annual_wage AS wage_growth,	
	CASE
		WHEN current.avg_annual_wage - previous.avg_annual_wage > 0 THEN 'Růst'
		WHEN current.avg_annual_wage - previous.avg_annual_wage < 0 THEN 'Pokles'
		ELSE 'Stabilita'
	END AS trend
FROM
	-- Subdotaz pro aktuální rok
	(SELECT
		industry_branch,
		year,
		AVG(average_wage) AS avg_annual_wage
	FROM
		t_tomas_stveracek_project_SQL_primary_final
	GROUP BY
		industry_branch,
		year) AS CURRENT
LEFT JOIN
	-- Subdotaz pro předchozí rok
	(SELECT
		industry_branch,
		year,
		AVG(average_wage) AS avg_annual_wage
	FROM
		t_tomas_stveracek_project_SQL_primary_final
	GROUP BY
		industry_branch,
		year) AS previous
ON
	current.industry_branch = previous.industry_branch AND
	current.year = previous.year + 1
ORDER BY
	current.industry_branch, current.year;
/*
 * Odpověď:
 * Na základě výsledků z analýzy změn mezd ve vybraných odvětvích v ČR mezi lety 2006 a 2018 můžeme konstatovat, 
 * že ve většině odvětví došlo k růstu mezd. V případech jako je "Zdravotní a sociální péče" došlo v roce 2018 k mírnému poklesu o -1.24 % oproti předchozímu roku,
 * jinak byl celkový dlouhodobý trend pozitivní. Větší pokles byl pozorován v "Veřejné správě a obraně; povinné sociální zabezpečení", 
 * kde mezi lety 2017 a 2018 došlo k poklesu mzdy o více než 3 %. Neexistuje žádné odvětví, kde by byl trend pouze růstový. 
 */
