/* SQL Queries
Luis Manuel Oros
Learn SQL From Scratch Intensive
June 5 - July 31 2018 Cohort */

/* Step 1.
- Exploration of survey table in database.
- First 10 rows. */
SELECT *
FROM survey
LIMIT 10;

/* Step 2.
Number of users that move from one question to the next.*/
SELECT question,
	COUNT(DISTINCT user_id)
FROM survey
GROUP BY question;

/* Step 4.
Exploring data from all tables in home_try_on funnel */
SELECT *
FROM quiz
LIMIT 5;

SELECT *
FROM home_try_on
LIMIT 5;

SELECT *
FROM purchase
LIMIT 5;

/* Step 5.
Creation of a new table by combining quiz, home_try_on, and purchase*/
SELECT DISTINCT quiz.user_id,
	home_try_on.user_id IS NOT NULL AS 'is_home_try_on',
	home_try_on.number_of_pairs,
	purchase.user_id IS NOT NULL AS 'is_purchase'
FROM quiz
LEFT JOIN home_try_on
	ON quiz.user_id = home_try_on.user_id
LEFT JOIN purchase
	ON purchase.user_id = quiz.user_id
LIMIT 10;

/* Step 6.
- Creation of a new table 'funnel.'
- Analysis to calculate the difference in purchase rates between customers who had 3 number_of_pairs vs 5. */
WITH funnel AS (
SELECT DISTINCT quiz.user_id,
	home_try_on.user_id IS NOT NULL AS 'is_home_try_on',
  home_try_on.number_of_pairs,
  purchase.user_id IS NOT NULL AS 'is_purchase'
FROM quiz
LEFT JOIN home_try_on
	ON quiz.user_id = home_try_on.user_id
LEFT JOIN purchase
	ON purchase.user_id = quiz.user_id)
SELECT number_of_pairs,
	COUNT(*) AS 'num_browse',
	SUM(is_home_try_on) AS 'num_home_try_on',
  SUM(is_purchase) AS 'num_purchase',
FROM funnel
GROUP BY number_of_pairs;
