--#1 How many of the sales reps have more than 5 accounts that they manage?

SELECT s.name rep_name, 
       COUNT(*) num_accts
FROM accounts a
JOIN sales_reps s
ON a.sales_rep_id = s.id
GROUP BY 1
HAVING COUNT(*) > 5

--#2 How many accounts have more than 20 orders?

SELECT a.name acct_name, 
       COUNT(*) num_orders
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY 1
HAVING COUNT(*) > 20

--#3 Which account has the most orders?

SELECT a.name account_name, 
       COUNT(*) num_orders
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1

--#4 Which accounts spent more than 30,000 usd total across all orders?

SELECT a.name account_name, 
       SUM(total_amt_usd) sum_total
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY 1
HAVING SUM(total_amt_usd) > 30000

--#5 Which accounts spent less than 1,000 usd total across all orders?

SELECT a.name account_name, 
       SUM(total_amt_usd) sum_total
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY 1
HAVING SUM(total_amt_usd) < 1000

--#6 Which account has spent the most with us?

SELECT a.name account_name, 
       SUM(total_amt_usd) sum_total
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1

--#7 Which account has spent the least with us?

SELECT a.name account_name, 
       SUM(total_amt_usd) sum_total
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY 1
ORDER BY 2
LIMIT 1

--#8 Which accounts used facebook as a channel to contact customers more than 6 times?

SELECT a.name account_name, 
       COUNT(*) num_contacts
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
GROUP BY 1
HAVING COUNT(*) > 6 AND w.channel = 'facebook'

--#9 Which account used facebook most as a channel?

SELECT a.name account_name, 
       COUNT(*) num_contacts
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
WHERE w.channel = 'facebook'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1

--#10 Which channel was most frequently used by most accounts?

SELECT channel, 
       COUNT(*) num_contacts
FROM web_events
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1
