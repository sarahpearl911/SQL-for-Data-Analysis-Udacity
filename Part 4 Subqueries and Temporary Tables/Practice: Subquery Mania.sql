-- #1 Provide the name of the sales rep in each region with the largest amount of total_amt_usd sales.

SELECT r_sub.max_sales,
       r_sub.r_name,
       rep_sub.sr_name
FROM (
     SELECT MAX(total_sales) max_sales, r_name
     FROM (
          SELECT SUM(total_amt_usd) total_sales,
                 r.name r_name,
                 s.name rep
          FROM orders o
          JOIN accounts a
          ON o.account_id = a.id
          JOIN sales_reps s
          ON s.id = a.sales_rep_id
          JOIN region r
          ON s.region_id = r.id
          GROUP BY 2, 3
          ) region_sub
          GROUP BY 2
      ) r_sub
JOIN (
     SELECT SUM(total_amt_usd) sales_amt,
            s.name sr_name
     FROM orders o
     JOIN accounts a
     ON o.account_id = a.id
     JOIN sales_reps s
     ON a.sales_rep_id = s.id
     GROUP BY 2
     ) rep_sub
ON r_sub.max_sales = rep_sub.sales_amt

-- #2 For the region with the largest sum of sales, how many total orders were placed?

SELECT r.name regname,
       COUNT(*) ocount,
       SUM(o.total_amt_usd) sumsales
FROM orders o
JOIN accounts a
ON o.account_id = a.id
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON s.region_id = r.id
GROUP BY 1
ORDER BY 3 DESC
LIMIT 1

-- #3 How many accounts had more total purchases than the account name which has bought the most standard_qty paper throughout their lifetime as a customer?

SELECT a.name aname,
       COUNT(*) num_purchases
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY 1
HAVING COUNT(*) > (
                  SELECT purch_amt
                  FROM (
                       SELECT a.name account_name,
                              SUM(standard_qty) standard_amt,
                              COUNT(*) purch_amt
                       FROM orders o
                       JOIN accounts a
                       ON o.account_id = a.id
                       GROUP BY 1
                       ORDER BY 2 DESC
                       LIMIT 1
                       ) t1
                  )

-- #4 For the customer that spent the most (in total over their lifetime as a customer), how many web_events did they have for each channel?

SELECT account_id,
       channel,
       COUNT(*) num_events
FROM web_events
WHERE account_id = (
                   SELECT accountid
                   FROM (
                        SELECT a.id accountid,
                               SUM(total_amt_usd) amt_spent
                        FROM orders o
                        JOIN accounts a
                        ON o.account_id = a.id
                        GROUP BY 1
                        ORDER BY 2 DESC
                        LIMIT 1
                        ) t1
                  )
GROUP BY 1, 2

-- #5 What is the lifetime average amount spent in terms of total_amt_usd for the top 10 spending accounts?

SELECT AVG(amt_spent) avg_amt
FROM (
     SELECT a.name,
            SUM(total_amt_usd) amt_spent
     FROM orders o
     JOIN accounts a
     ON o.account_id = a.id
     GROUP BY 1
     ORDER BY 2 DESC
     LIMIT 10
     ) t1

-- #6 What is the lifetime average amount spent in terms of total_amt_usd, including only the companies that spent more per order, on average, than the average of all orders?

SELECT AVG(avg_spent) avg_amt
FROM (
     SELECT account_id,
            AVG(total_amt_usd) avg_spent
     FROM orders
     GROUP BY 1
     HAVING AVG(total_amt_usd) > (
                                 SELECT AVG(total_amt_usd) avg_all
                                 FROM orders
                                 )
     ) t1
