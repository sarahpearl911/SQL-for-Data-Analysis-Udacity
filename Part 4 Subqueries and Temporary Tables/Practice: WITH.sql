-- #1 Provide the name of the sales rep in each region with the largest amount of total_amt_usd sales.

--finding sum of sales for each sales rep

WITH rep_totals AS(
                  SELECT s.name r_name,
                         SUM(total_amt_usd) sales_amt
                  FROM orders o
                  JOIN accounts a
                  ON o.account_id = a.id
                  JOIN sales_reps s
                  ON s.id = a.sales_rep_id
                  GROUP BY 1
                  ),

--finding max sum of sales for each region

region_totals AS (
                 SELECT MAX(total_amt) max_sales,
                        region_name
                 FROM (
                      SELECT r.name region_name,
                             s.name reps_name,
                             SUM(total_amt_usd) total_amt
                      FROM orders o
                      JOIN accounts a
                      ON o.account_id = a.id
                      JOIN sales_reps s
                      ON a.sales_rep_id = s.id
                      JOIN region r
                      ON s.region_id = r.id
                      GROUP BY 1, 2
                      ) t1
                GROUP BY 2
                )

SELECT reg.region_name region,
       rep.r_name rep_name,
       MAX(reg.max_sales) total_sales
FROM rep_totals rep
JOIN region_totals reg
ON rep.sales_amt = reg.max_sales
GROUP BY 1, 2

-- #2 For the region with the highest sales, how many total orders were placed?

SELECT r.name region_name,
       COUNT(*) num_sales,
       SUM(total_amt_usd) total_sales
FROM orders o
JOIN accounts a
ON o.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id
GROUP BY 1
ORDER BY 3 DESC
LIMIT 1

--found the solution with the above query, but i wanted to get practice with WITH statements, so i came up with the below query

--finding sum of sales by region


WITH region_sales AS (
                     SELECT r.name region_name,
                            SUM(total_amt_usd) sum_sales
                     FROM orders o
                     JOIN accounts a
                     ON o.account_id = a.id
                     JOIN sales_reps s
                     ON a.sales_rep_id = s.id
                     JOIN region r
                     ON s.region_id = r.id
                     GROUP BY 1
                     ),

--finding max sum of sales

max_region AS (
              SELECT MAX(sum_sales)
              FROM region_sales
              )

SELECT r.name region_name,
       COUNT(*)
FROM orders o
JOIN accounts a
ON o.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id
GROUP BY 1
HAVING SUM(o.total_amt_usd) = (
                              SELECT * 
                              FROM max_region
                              )

-- #3 How many accounts had more total purchases than the account which has bought the most standard_qty paper throughout their lifetime as a customer?

--finding account that bought the most standard paper

WITH max_standard AS (
                     SELECT account_id,
                            SUM(standard_qty) total_standard,
                            COUNT(total) num_purch
                     FROM orders
                     GROUP BY 1
                     ORDER BY 2 DESC
                     LIMIT 1
                     ),

--making a list of accounts with more purchases

max_totals AS (
              SELECT account_id
              FROM orders
              GROUP BY 1
              HAVING COUNT(total) > (
                                    SELECT num_purch 
                                    FROM max_standard
                                    )
              )

SELECT COUNT(*)
FROM max_totals

-- #4 For the customer that spent the most total_amt_usd, how many web_events did they have for each channel?

--finding the customer who spent the most

WITH most_spent AS (
                   SELECT account_id,
                          SUM(total_amt_usd) amt_spent
                   FROM orders
                   GROUP BY 1
                   ORDER BY 2 DESC
                   LIMIT 1
                   ),

--getting a list of their web events

events_id AS (
             SELECT channel,
                    account_id
             FROM web_events
             WHERE account_id = (
                                SELECT account_id 
                                FROM most_spent
                                )
             )

SELECT channel,
       COUNT(*) num_events
FROM events_id
GROUP BY 1

-- #5 What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?

--finding highest spending accounts

WITH top_accts AS (
                  SELECT account_id,
                         SUM(total_amt_usd) amt_spent
                  FROM orders 
                  GROUP BY 1
                  ORDER BY 2 DESC
                  LIMIT 10
                  )

SELECT AVG(amt_spent) avg_spent
FROM top_accts


-- #6 What is the lifetime average amount spent in terms of total_amt_usd, including only the companies that spent more per order, on average, than the average of all orders?

WITH highest_avg AS (
                    SELECT a.name,
                           AVG(total_amt_usd) avg_spent
                    FROM orders o
                    JOIN accounts a
                    ON o.account_id = a.id
                    GROUP BY 1
                    HAVING AVG(total_amt_usd) > (
                                                SELECT AVG(total_amt_usd) 
                                                FROM orders 
                                                )
                    )

SELECT AVG(avg_spent) total_avg
FROM highest_avg
