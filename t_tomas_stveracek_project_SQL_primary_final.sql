DROP TABLE IF EXISTS t_tomas_stveracek_project_SQL_primary_final;

CREATE TABLE t_tomas_stveracek_project_SQL_primary_final AS
WITH payroll_aggregate AS (
    SELECT
        payroll_year,
        payroll_quarter,
        industry_branch_code,
        AVG(value) AS avg_wage
    FROM
        czechia_payroll
    GROUP BY
        payroll_year,
        payroll_quarter,
        industry_branch_code
),
price_aggregate AS (
    SELECT 
        YEAR(date_from) AS year,
        QUARTER(date_from) AS quarter, 
        category_code,
        AVG(value) AS avg_price
    FROM 
        czechia_price
    GROUP BY
        YEAR(date_from),
        QUARTER(date_from), 
        category_code
)
SELECT
    pa.payroll_year AS year,
    pa.payroll_quarter AS quarter,
    cpib.name AS industry_branch,
    pa.avg_wage AS average_wage,
    cpc.name AS category,
    pra.avg_price AS average_price
FROM
    payroll_aggregate pa
JOIN
    price_aggregate pra ON pa.payroll_year = pra.year AND pa.payroll_quarter = pra.quarter
JOIN
    czechia_payroll_industry_branch cpib ON pa.industry_branch_code = cpib.code
JOIN
    czechia_price_category cpc ON pra.category_code = cpc.code;
