/*
 *  Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
 */

SELECT
  current.industry_branch,
  current.year,
  current.avg_annual_wage,
  previous.avg_annual_wage AS previous_year_avg_wage,
  (current.avg_annual_wage - previous.avg_annual_wage) AS wage_growth
FROM
  (SELECT
     industry_branch,
     year,
     AVG(average_wage) AS avg_annual_wage
   FROM
     t_tomas_stveracek_project_SQL_primary_final
   GROUP BY
     industry_branch,
     year) AS current
LEFT JOIN
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
  current.year = previous.year + 1;
