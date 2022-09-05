--#1 Use DISTINCT to test if there are any accounts associated with more than one region.

SELECT a.name account_name, 
       COUNT(DISTINCT r.name) region_count
FROM accounts a
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id
GROUP BY 1
ORDER BY 2 DESC

--#2 Have any sales reps worked on more than one account?

SELECT s.name rep_name, 
       COUNT(DISTINCT a.name) account_count
FROM accounts a
JOIN sales_reps s
ON a.sales_rep_id = s.id
GROUP BY 1
ORDER BY 2 DESC
