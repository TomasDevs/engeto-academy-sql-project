/*
 * Výzkumná otázka 3:
 * Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
 */

-- Dočasná tabulka pro cískání průmerných cen jednotlivých kategorií potravin za každý rok
WITH YearlyPriceChange AS (
	SELECT
		category,
		year,
		AVG(average_price) AS avg_price	
	FROM
		t_tomas_stveracek_project_SQL_primary_final
	GROUP BY
		category, year
),
-- Dočasná tabulka pro výpočet předchozí ceny potravin v každé kategorii pro každý rok
CalculatedChanges AS (
	SELECT
		category,
		year,
		avg_price,
		LAG(avg_price) OVER (PARTITION BY category ORDER BY year) AS previous_price
	FROM
		YearlyPriceChange
),
-- Dočasná tabulka pro výpočet procentuální změny mezi průměrnými cenami v jednotlivých rocích
AnnualPercentageChange AS (
	SELECT
		category,
		year,
		CASE 
			WHEN previous_price IS NOT NULL THEN ROUND(((avg_price - previous_price) / previous_price) * 100, 2)
		END AS percent_change
	FROM
		CalculatedChanges
	WHERE
		previous_price IS NOT NULL
)
-- Hlavní dotaz, který vrací kategorie potravin s průměrnou procentuální změnou ceny
SELECT
	category,
	ROUND(AVG(percent_change), 2) AS avg_percent_change
FROM
	AnnualPercentageChange
GROUP BY
	category
ORDER BY
	avg_percent_change ASC;

/*
 * Odpověď:
 * Nejpomalejší zdražování bylo zaznamenáno u kategorie "Cukr krystalový", který nejenže nezaznamenal růst, 
 * ale naopak vykázal průměrný pokles cen o -1.92 % ročně.
 */




