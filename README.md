# engeto-academy-sql-project

Repozitář obsahuje SQL projekt z kurzu Engeto Academy.

## Zadání

#### Primární tabulky:

**czechia_payroll** – Informace o mzdách v různých odvětvích za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR.

**czechia_payroll_calculation** – Číselník kalkulací v tabulce mezd.

**czechia_payroll_industry_branch** – Číselník odvětví v tabulce mezd.

**czechia_payroll_unit** – Číselník jednotek hodnot v tabulce mezd.

**czechia_payroll_value_type** – Číselník typů hodnot v tabulce mezd.

**czechia_price** – Informace o cenách vybraných potravin za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR.

**czechia_price_category** – Číselník kategorií potravin, které se vyskytují v našem přehledu.

#### Číselníky sdílených informací o ČR:

**czechia_region** – Číselník krajů České republiky dle normy CZ-NUTS 2.

**czechia_district** – Číselník okresů České republiky dle normy LAU.

#### Dodatečné tabulky:

**countries** - Všemožné informace o zemích na světě, například hlavní město, měna, národní jídlo nebo průměrná výška populace.

**economies** - HDP, GINI, daňová zátěž, atd. pro daný stát a rok.

### Výzkumné otázky

1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?

#### Výstup projektu

Výstupem by měly být dvě tabulky v databázi, ze kterých se požadovaná data dají získat. Tabulky pojmenujte t*{jmeno}*{prijmeni}_project_SQL_primary_final (pro data mezd a cen potravin za Českou republiku sjednocených na totožné porovnatelné období – společné roky) a t_{jmeno}\_{prijmeni}\_project_SQL_secondary_final (pro dodatečná data o dalších evropských státech).

Dále připravte sadu SQL, které z vámi připravených tabulek získají datový podklad k odpovězení na vytyčené výzkumné otázky. Pozor, otázky/hypotézy mohou vaše výstupy podporovat i vyvracet! Záleží na tom, co říkají data.

## Odpovědi na otázky

**1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?**

Na základě výsledků z analýzy změn mezd ve vybraných odvětvích v ČR mezi lety 2006 a 2018 můžeme konstatovat, že ve většině odvětví došlo k růstu mezd. V případech jako je "Zdravotní a sociální péče" došlo v roce 2018 k mírnému poklesu o -1.24 % oproti předchozímu roku, jinak byl celkový dlouhodobý trend pozitivní. Větší pokles byl pozorován v "Veřejné správě a obraně; povinné sociální zabezpečení", kde mezi lety 2017 a 2018 došlo k poklesu mzdy o více než 3 %. Neexistuje žádné odvětví, kde by byl trend pouze růstový.
Odkaz na: [SQL kód](https://github.com/TomasDevs/engeto-academy-sql-project/blob/main/question1_wage_growth_by_industry.sql)

**2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?**

Analýza ukazuje zlepšní kupní síly chleba a mléka mezi roky 2006 a 2018. Zatímco v roce 2006 bylo možné koupit za průměrnou mzdu 1.217 kg chleba a 1.363 litrů mléka, v roce 2018 se toto množství zvýšilo na 1.267 kg chleba a 1.55 litrů mléka.
[SQL kód](https://github.com/TomasDevs/engeto-academy-sql-project/blob/main/question2_number_purchases_milk_bread.sql)

**3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?**

Nejpomalejší zdražování bylo zaznamenáno u kategorie "Cukr krystalový", který nejenže nezaznamenal růst, ale naopak vykázal průměrný pokles cen o -1.92 % ročně.
[SQL kód](https://github.com/TomasDevs/engeto-academy-sql-project/blob/main/question3_slowest_food_price_increase.sql)

**4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?**

Dle reportu v roce 2013 došlo k nárůstu cen potravin ve srovnání s růstem mezd s rozdílem přesahuícím 10 % (konkrétně 11.06 %).
[SQL kód](https://github.com/TomasDevs/engeto-academy-sql-project/blob/main/question4_year_with_price_wage_discrepancy.sql)

**5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?**

Podle výstupu z této analýzy lze usoudit, že existuje korelace mezi výškou HDP a změnami ve mzdých nebo cenách potravin. Například v roce 2018 ja patrně velký nárůst mezd ve srovnání s mírným růstem cen a velkým růstem HDP. To naznačuje, že vyšší HDP může vést k vyšším mzdám. Nicméně dle výsledků se zdá, že korelace není konzistentní každý rok.
[SQL kód](https://github.com/TomasDevs/engeto-academy-sql-project/blob/main/question5_gdp_impact_on_wages_prices.sql)
