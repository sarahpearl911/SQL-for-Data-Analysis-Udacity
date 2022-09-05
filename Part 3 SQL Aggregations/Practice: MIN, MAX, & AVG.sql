--#1 When was the earliest order ever placed? You only need to return the date.

SELECT MIN(occurred_at) earliest
FROM orders

--#2 Try performing the same query as in question 1 without using an aggregation function.

SELECT occurred_at
FROM orders
ORDER BY occurred_at 
LIMIT 1

--#3 When did the most recent (latest) web_event occur?

SELECT MAX(occurred_at) most_recent
FROM web_events

--#4 Try to perform the result of the previous query without using an aggregation function.

SELECT occurred_at
FROM web_events
ORDER BY occurred_at DESC
LIMIT 1

--#5 Find the mean (AVERAGE) amount spent per order on each paper type, as well as the mean amount of each paper type purchased per order. Your final answer should have 6 values - one for each paper type for the average number of sales, as well as the average amount.

SELECT AVG(standard_amt_usd) standard_avg_usd, 
       AVG(poster_amt_usd) poster_avg_usd, 
       AVG(gloss_amt_usd) gloss_avg_usd, 
       AVG(standard_qty) avg_standard_qty, 
       AVG(poster_qty) avg_poster_qty, 
       AVG(gloss_qty) avg_gloss_qty
FROM orders
