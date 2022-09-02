-- #1 Using the table sf_crime_data, reformat date column and change data type to DATE.

WITH date_parts AS (
                   SELECT date,
                          SUBSTR(date, 1, 2) new_month,
                          SUBSTR(date, 4, 2) new_day,
                          SUBSTR(date, 7, 4) new_year
                          FROM sf_crime_data
                   )

SELECT date,
       CAST(new_year||'-'||new_month||'-'||new_day AS DATE) new_date
FROM date_parts

--another way to do it

SELECT date,
       (SUBSTR(date, 7, 4)||'-'||SUBSTR(date, 1, 2)||'-'||SUBSTR(date, 4, 2))::DATE new_date
FROM sf_crime_data

-- #2 Fill in the null values with the appropriate ids and with 0 in the qty and usd columns.

SELECT COALESCE(o.id, a.id) filled_id,
       a.name,
       a.website,
       a.lat,
       a.long,
       a.primary_poc,
       a.sales_rep_id,
       COALESCE(o.account_id, a.id) account_id,
       COALESCE(o.standard_qty, 0) standard_qty,
       COALESCE(o.poster_qty, 0) poster_qty,
       COALESCE(o.gloss_qty, 0) gloss_qty,
       COALESCE(o.total, 0) total, 
       o.occurred_at,
       COALESCE(o.standard_amt_usd, 0) standard_amt_usd, 
       COALESCE(o.gloss_amt_usd, 0) gloss_amt_usd,
       COALESCE(o.poster_amt_usd, 0) poster_amt_usd,
       COALESCE(o.total_amt_usd, 0) total_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
