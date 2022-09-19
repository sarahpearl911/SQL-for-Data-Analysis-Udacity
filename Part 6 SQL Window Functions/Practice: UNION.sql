--#1 Write a query that uses UNION ALL on two instances (and selecting all columns) of the accounts table.

SELECT *
FROM accounts
UNION ALL
SELECT *
FROM accounts

--#2 Add a WHERE clause to each of the tables that you unioned in the query above, filtering the first table where name equals Walmart and filtering the second table where name equals Disney.

SELECT *
FROM accounts
WHERE name = 'Walmart'
UNION ALL
SELECT *
FROM accounts
WHERE name = 'Disney'

--#3 Perform the union in your first query (under the Appending Data via UNION header) in a common table expression and name it double_accounts. Then do a COUNT the number of times a name appears in the double_accounts table. If you do this correctly, your query results should have a count of 2 for each name.

WITH double_accounts AS (
  SELECT *
FROM accounts
UNION ALL
SELECT *
FROM accounts)

SELECT name, COUNT(name)
FROM double_accounts
GROUP BY name
