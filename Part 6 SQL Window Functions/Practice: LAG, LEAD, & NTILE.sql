--#1 Imagine you're an analyst at Parch & Posey and you want to determine how the current order's total revenue ("total" meaning from sales of all types of paper) compares to the next order's total revenue. In your query results, there should be four columns: occurred_at, total_amt_usd, lead, and lead_difference.

SELECT occurred_at, 
       total_amt_usd, 
       LEAD(total_amt_usd) OVER (ORDER BY occurred_at) lead, 
       LEAD(total_amt_usd) OVER (ORDER BY occurred_at) - total_amt_usd lead_difference
FROM orders

--#2 Use the NTILE functionality to divide the accounts into 4 levels in terms of the amount of standard_qty for their orders. Your resulting table should have the account_id, the occurred_at time for each order, the total amount of standard_qty paper purchased, and one of four levels in a standard_quartile column.

SELECT account_id, 
       occurred_at, 
       standard_qty, 
       NTILE(4) OVER (PARTITION BY account_id ORDER BY standard_qty) standard_quartile
FROM orders

--#3 Use the NTILE functionality to divide the accounts into two levels in terms of the amount of gloss_qty for their orders. Your resulting table should have the account_id, the occurred_at time for each order, the total amount of gloss_qty paper purchased, and one of two levels in a gloss_half column.

SELECT account_id, 
       occurred_at, 
       gloss_qty, 
       NTILE(2) OVER (PARTITION BY account_id ORDER BY gloss_qty) gloss_half
FROM orders

--#4 Use the NTILE functionality to divide the orders for each account into 100 levels in terms of the amount of total_amt_usd for their orders. Your resulting table should have the account_id, the occurred_at time for each order, the total amount of total_amt_usd paper purchased, and one of 100 levels in a total_percentile column.

SELECT account_id, 
       occurred_at, 
       total_amt_usd, 
       NTILE(100) OVER (PARTITION BY account_id ORDER BY total_amt_usd) total_percentile
FROM orders
