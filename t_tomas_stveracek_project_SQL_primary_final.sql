DROP TABLE IF EXISTS t_tomas_stveracek_project_SQL_primary_final;

CREATE TABLE t_tomas_stveracek_project_SQL_primary_final AS
SELECT
	cp.payroll_year AS year,
	cp.payroll_quarter AS quarter,
	cpib.name AS industry_branch,
	cpvt.name AS value_type,
	cpu.name AS unit,
	cpc.name AS category,
	AVG(cpr.value) AS average_price,
	AVG(cp.value) AS average_wage
FROM
	czechia_payroll cp 
JOIN
	czechia_payroll_industry_branch cpib ON cp.industry_branch_code = cpib.code
JOIN 
	czechia_payroll_value_type cpvt ON cp.value_type_code = cpvt.code
JOIN
	czechia_payroll_unit cpu ON cp.unit_code = cpu.code
JOIN
	czechia_price cpr ON YEAR(cpr.date_from) = cp.payroll_year AND QUARTER(cpr.date_from) = cp.payroll_quarter
JOIN
	czechia_price_category cpc ON cpr.category_code = cpc.code
WHERE
	cp.payroll_year = YEAR(cpr.date_from) AND
	cp.payroll_quarter = QUARTER(cpr.date_from)
GROUP BY
	cp.payroll_year,
	cp.payroll_quarter,
	cpib.name,
	cpvt.name,
	cpu.name,
	cpc.name;