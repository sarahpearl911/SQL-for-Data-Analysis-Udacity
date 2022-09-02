-- #1 Each company in the accounts table wants to create an email address for each primary_poc. The email address should be the first name of the primary_poc. last name primary_poc @ company name .com.

SELECT primary_poc,
       name,
       CONCAT(LEFT(primary_poc, STRPOS(primary_poc, ' ') -1), '.', RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')), '@', name, '.com') email
FROM accounts


-- #2 You may have noticed that in the previous solution some of the company names include spaces, which will certainly not work in an email address. See if you can create an email address that will work by removing all of the spaces in the account name, but otherwise your solution should be just as in question 1.

--i did some googling and found the replace function to take care of this issue

WITH email_space AS (
                    SELECT primary_poc,
                           name,
                           CONCAT(LEFT(primary_poc, STRPOS(primary_poc, ' ') -1), '.', RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')), '@', name, '.com') email
                    FROM accounts
                    )

SELECT primary_poc,
       name,
       REPLACE(email, ' ', '') email
FROM email_space

-- #3 We would also like to create an initial password, which they will change after their first log in. The first password will be the first letter of the primary_poc's first name (lowercase), then the last letter of their first name (lowercase), the first letter of their last name (lowercase), the last letter of their last name (lowercase), the number of letters in their first name, the number of letters in their last name, and then the name of the company they are working with, all capitalized with no spaces.

--using temp tables for the sake of readability


WITH first_last AS (
                   SELECT primary_poc,
                          name,
                          LEFT(primary_poc, STRPOS(primary_poc, ' ') -1) first_name,
                          RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name
                   FROM accounts
                   ),

name_letters AS (
                SELECT primary_poc,
                       name,
                       LOWER(LEFT(first_name, 1)) first_name_first,
                       LOWER(RIGHT(first_name, 1)) first_name_last,
                       LOWER(LEFT(last_name, 1)) last_name_first,
                       LOWER(RIGHT(last_name, 1)) last_name_last,
                       LENGTH(first_name) first_length,
                       LENGTH(last_name) last_length
                FROM first_last
                )

SELECT primary_poc,
       name,
       CONCAT(first_name_first, first_name_last, last_name_first, last_name_last, first_length, last_length, UPPER(REPLACE(name, ' ', ''))) first_password
FROM name_letters
