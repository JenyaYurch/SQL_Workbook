-- Scalar subquery Country-Customer
SELECT 
	cou.country_name
	,(SELECT max(cust.cust_credit_limit)
		FROM sh.customers cust 
		WHERE cust.country_id = cou.country_id
		)
FROM 
	sh.countries cou;

-- Scalar subquery Channel-Amount
-- It is a scalar subquery because it returns a single value 
-- (the sum of the totals sales for a given channel)
SELECT 
	ch.channel_desc
	,(SELECT SUM(sal.amount_sold)
		FROM sh.sales sal 
		WHERE sal.channel_id = ch.channel_id
		) AS Total_Amount_By_Channel
FROM 
	sh.channels ch
ORDER BY 
	Total_Amount_By_Channel DESC;


-- This query should return the same result as the scalar subquery approach
-- , but it might be more efficient for large TABLES
--, as JOINs can often be faster than subqueries.
SELECT 
	ch.channel_desc
	,SUM(sal.amount_sold) AS Total_Amount_By_Channel
FROM 
	sh.sales sal 
	RIGHT JOIN sh.channels ch ON sal.channel_id = ch.channel_id
GROUP BY 
	ch.channel_desc
ORDER BY 
	Total_Amount_By_Channel DESC;
