/*
 * Výzkumná otázka 2:
 * Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
 */

SELECT
  year,
  SUM(CASE WHEN category LIKE '%mléko%' THEN average_wage / average_price ELSE 0 END) AS liters_of_milk,
  SUM(CASE WHEN category LIKE '%chléb%' THEN average_wage / average_price ELSE 0 END) AS kg_of_bread
FROM
  t_tomas_stveracek_project_SQL_primary_final
WHERE
  year IN (2006, 2018)
GROUP BY
  year;
