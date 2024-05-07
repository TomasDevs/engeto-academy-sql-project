/*
 * 5. Výzkumná otázka:
 * Má výška HDP vliv na změny ve mzdách a cenách potravin? 
 * Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách 
 * ve stejném nebo následujícím roce výraznějším růstem?
 */

-- Výpočet roční procentuální změny HDP pro Českou republiku
WITH GDPChanges AS (
	SELECT
		year,
		GDP,
		LAG(GDP) OVER (ORDER BY year) AS prev_GDP -- Získání hodnoty HDP z předchozího roku
	FROM
		t_tomas_stveracek_project_SQL_secondary_final
	WHERE
		country = 'Czech Republic' AND GDP IS NOT NULL
),
GDPAnnualChange AS (
	SELECT
		year,
		GDP,
		prev_GDP,
		CASE
			WHEN prev_GDP > 0 THEN (GDP - prev_GDP) / prev_GDP * 100 -- Procentuální změna HDP
			ELSE NULL
		END AS GDP_change_pct
	FROM
		GDPChanges
),
-- Tabulka zahrnující data o průměrných mzdách a cenách za stejné roky
WagePriceData AS (
	SELECT
		year,
		AVG(average_wage) AS avg_wage,
		AVG(average_price) AS avg_price
	FROM
	t_tomas_stveracek_project_SQL_primary_final
	GROUP BY
		year
),
WagePriceChanges AS (
	SELECT
		year,
		avg_wage,
		avg_price,
		LAG(avg_wage) OVER (ORDER BY year) AS prev_avg_wage,
		LAG(avg_price) OVER (ORDER BY year) AS prev_avg_price
	FROM
		WagePriceData
),
-- Kombinace dat o změnách HDP s daty o mzdách a cenách
AnnualChanges AS (
	SELECT
		g.year,
		g.GDP_change_pct,
		((w.avg_wage - w.prev_avg_wage) / w.prev_avg_wage) * 100 AS wage_change_pct,
		((w.avg_price - w.prev_avg_price) / w.prev_avg_price) * 100 AS price_change_pct
	FROM
		GDPAnnualChange g
	LEFT JOIN
		WagePriceChanges w ON g.year = w.year
	WHERE
		w.prev_avg_wage IS NOT NULL AND w.prev_avg_price IS NOT NULL
)
-- Výběr dat 
SELECT
	year,
	GDP_change_pct,
	wage_change_pct,
	price_change_pct
FROM
	AnnualChanges
ORDER BY
	year;

/*
 * Odpověď:
 * Podle výstupu z této analýzy lze usoudit, že existuje korelace mezi výškou HDP a změnami ve mzdých nebo cenách potravin.
 * Například v roce 2018 ja patrně velký nárůst mezd ve srovnání s mírným růstem cen a velkým růstem HDP.  
 * To naznačuje, že vyšší HDP může vést k vyšším mzdám. Nicméně dle výsledků se zdá, že korelace není konzistentní každý rok.
 */
