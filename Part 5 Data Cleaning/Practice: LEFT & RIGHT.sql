-- #1 In the accounts table, there is a column holding the website for each company. The last three digits specify what type of web address they are using. Pull these extensions and provide how many of each website type exist in the accounts table.

SELECT RIGHT(website, 3) address_type,
       COUNT(*) num_companies
FROM accounts
GROUP BY 1

-- #2 There is much debate about how much the name (or even the first letter of a company name) matters. Use the accounts table to pull the first letter of each company name to see the distribution of company names that begin with each letter (or number).

SELECT LEFT(name, 1) first_char,
       COUNT(*) num_names
FROM accounts
GROUP BY 1
ORDER BY 2

-- #3 Use the accounts table and a CASE statement to create two groups: one group of company names that start with a number and a second group of those company names that start with a letter. What proportion of company names start with a letter?

SELECT CASE 
           WHEN LEFT(UPPER(name), 1) BETWEEN 'A' and 'Z' THEN 'letter'
           ELSE 'number'
       END first_char,
       COUNT(*)
FROM accounts
GROUP BY 1

-- #4 Consider vowels as a, e, i, o, and u. What proportion of company names start with a vowel, and what percent start with anything else?

WITH t_vowel AS (
                SELECT CASE 
                           WHEN LEFT(LOWER(name), 1) IN ('a', 'e', 'i', 'o', 'u') THEN 1
                           ELSE 0
                END v,
                CASE 
                    WHEN LEFT(LOWER(name), 1) NOT IN ('a', 'e', 'i', 'o', 'u')
                    THEN 1
                    ELSE 0
                END nv
                FROM accounts
                )

SELECT SUM(v) vowels,
       SUM(nv) not_vowels
FROM t_vowel
