--#1 Find the sales in terms of total dollars for all orders in each year, ordered from greatest to least.

SELECT DATE_PART('year', occurred_at) order_year, 
       SUM(total_amt_usd) sum_total
FROM orders
GROUP BY 1
ORDER BY 2 DESC

--#2 Which month did Parch & Posey have the greatest sales in terms of total dollars?

SELECT DATE_PART('month', occurred_at) order_month, 
       SUM(total_amt_usd) sum_total
FROM orders
GROUP BY 1
ORDER BY 2 DESC

--#3 Which year did Parch & Posey have the greatest sales in terms of total number of orders?

SELECT DATE_PART('year', occurred_at) order_year, 
       SUM(total) num_orders
FROM orders
GROUP BY 1
ORDER BY 2 DESC

--#4 Which month did Parch & Posey have the greatest sales in terms of total number of orders?

SELECT DATE_PART('month', occurred_at) order_month, 
       SUM(total) num_orders
FROM orders
GROUP BY 1
ORDER BY 2 DESC

--#5 In which month of which year did Walmart spend the most on gloss paper in terms of dollars?

SELECT DATE_TRUNC('month', occurred_at) order_month, 
       SUM(o.gloss_amt_usd), a.name
FROM orders o
JOIN accounts a
ON o.account_id = a.id
WHERE a.name = 'Walmart'
GROUP BY 1, 3
ORDER BY 2 DESC
