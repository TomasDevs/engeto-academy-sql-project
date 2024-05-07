/*
 * Výzkumná otázka 2:
 * Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
 */

-- Dotaz vypočítává, kolik jednotek mléka nebo chleba lze koupit za průměrnou mzdu
SELECT
	year,
	category,
	ROUND(AVG(average_price), 2) AS avg_price,
	ROUND(AVG(average_wage), 2) AS avg_wage,
	ROUND(AVG(average_wage) / AVG(average_price)) AS units_purchasable
FROM
	t_tomas_stveracek_project_SQL_primary_final
WHERE
	year IN (2006, 2018) AND
	(category LIKE '%mléko%' OR category LIKE '%chléb%')
GROUP BY
	year, category
ORDER BY
	year, category;

/*
 * Odpověď:
 * Analýza ukazuje zlepšní kupní síly chleba a mléka mezi roky 2006 a 2018.
 * Zatímco v roce 2006 bylo možné koupit za průměrnou mzdu 1.217 kg chleba a 1.363 litrů mléka,
 * v roce 2018 se toto množství zvýšilo na 1.267 kg chleba a 1.55 litrů mléka.
 */ 
