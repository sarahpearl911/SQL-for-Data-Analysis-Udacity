--#1 Which account (by name) placed the earliest order? Your solution should have the account name and the date of the order.

SELECT a.name account_name, 
       MIN(o.occurred_at) order_date
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY account_name
ORDER BY order_date
LIMIT 1

--#2 Find the total sales in usd for each account. You should include two columns - the total sales for each company's orders in usd and the company name.

SELECT a.name account_name, 
       SUM(o.total_amt_usd) total_sales
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY a.name

--#3 Via what channel did the most recent (latest) web_event occur, which account was associated with this web_event? Your query should return only three values - the date, channel, and account name.

SELECT a.name account_name, 
       MAX(w.occurred_at) event_date, 
       w.channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY 1, 3
ORDER BY 2 DESC
LIMIT 1

--#4 Find the total number of times each type of channel from the web_events was used. Your final table should have two columns - the channel and the number of times the channel was used.

SELECT channel, 
       COUNT(*) num_used
FROM web_events
GROUP BY 1

--#5 Who was the primary contact associated with the earliest web_event?

SELECT a.primary_poc primary_contact, 
       MIN(w.occurred_at) date_occurred
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY 1
ORDER BY 2
LIMIT 1

--#6 What was the smallest order placed by each account in terms of total usd. Provide only two columns - the account name and the total usd. Order from smallest dollar amounts to largest.

SELECT a.name account_name, 
       MIN(total_amt_usd) smallest_amt
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY 1

--#7 Find the number of sales reps in each region. Your final table should have two columns - the region and the number of sales_reps. Order from fewest reps to most reps.

SELECT r.name region_name, 
       COUNT(s.id) rep_count
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
GROUP BY r.name
ORDER BY rep_count

--#8 For each account, determine the average amount of each type of paper they purchased across their orders. Your result should have four columns - one for the account name and one for the average quantity purchased for each of the paper types for each account.

SELECT a.name account_name, 
       AVG(standard_qty) avg_standard, 
       AVG(poster_qty) avg_poster, 
       AVG(gloss_qty) avg_gloss
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY 1

--#9 For each account, determine the average amount spent per order on each paper type. Your result should have four columns - one for the account name and one for the average amount spent on each paper type.

SELECT a.name account_name, 
       AVG(standard_amt_usd) avg_standard_usd, 
       AVG(poster_amt_usd) avg_poster_usd, 
       AVG(gloss_amt_usd) avg_gloss_usd
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY 1

--#10 Determine the number of times a particular channel was used in the web_events table for each sales rep. Your final table should have three columns - the name of the sales rep, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.

SELECT s.name rep_name, 
       w.channel, 
       COUNT(*) total
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
GROUP BY 1, 2
ORDER BY 3 DESC

--#11 Determine the number of times a particular channel was used in the web_events table for each region. Your final table should have three columns - the region name, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.

SELECT w.channel, 
       COUNT(*) num_used, 
       r.name region_name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id
GROUP BY 1, 3
ORDER BY 2 DESC
