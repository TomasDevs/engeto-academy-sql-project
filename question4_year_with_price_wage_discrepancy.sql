/*
 * Výzkumná otázka 4:
 * Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
 */
   
-- Dočasná tabulka (CTE) YearlyData výpočítává průměrné ceny a mzdy za každý rok a zároveň získá hodnoty z předchozího roku pro porovnání
WITH YearlyData AS (
	SELECT
		year,
		AVG(average_price) AS avg_price,
		LAG(AVG(average_price), 1) OVER (ORDER BY year) AS prev_price,
		AVG(average_wage) AS avg_wage,
		LAG(AVG(average_wage), 1) OVER (ORDER BY year) AS prev_wage
	FROM
		t_tomas_stveracek_project_SQL_primary_final
	GROUP BY
		year
),
-- CTE PriceWageDifferences vypočítá procentuální změny mezi průměrnými cenami a mzdami, poté zjišťuje mezi nimi rozdíl 
PriceWageDifferences AS (
	SELECT
		year,
		(avg_price - prev_price) / prev_price * 100 AS price_change_pct,
		(avg_wage - prev_wage) / prev_wage * 100 AS wage_change_pct,
		((avg_price - prev_price) / prev_price * 100) - ((avg_wage - prev_wage) / prev_wage * 100) AS difference_pct
	FROM
		YearlyData
	WHERE
		prev_price IS NOT NULL AND prev_wage IS NOT NULL
)
-- Výběr roků, kde rozdíl mezi procentuální změnou cen a mezd je větší než 10 %
SELECT
	year,
	price_change_pct,
	wage_change_pct,
	difference_pct
FROM
	PriceWageDifferences
WHERE
	difference_pct > 10;

/*
 * Odpověď:
 * Dle reportu v roce 2013 došlo k nárůstu cen potravin ve srovnání s růstem mezd
 * s rozdílem přesahuícím 10 % (konkrétně 11.06 %). 
 */
 
