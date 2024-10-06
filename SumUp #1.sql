-- GROUP BY: sales_rep_ID
-- FILTER: year 2024, month of August
-- OUTPUT: sales_rep_ID, total_sales
-- ORDER BY: total_sales DESC

SELECT name, SUM(subscription_cost)
FROM sales AS s
JOIN sales_representatives AS s_r
	ON s.sales_rep_id = s_r.id
WHERE MONTH(contract_signed_date) = 8 AND YEAR(contract_signed_date) = 2024
GROUP BY name
ORDER name DESC;

-- return the highest grossing product
-- JOIN sales TO products ON p.id = s.product_id
-- GROUP BY: total_sales for each product 
-- FILTER: year = 2024, month < 4
-- OUTPUT: name, total_sales = SUM(subscription_cost)
-- ORDER BY: total_sales DESC

SELECT name, SUM(subscription_cost) AS total_sales
FROM sales AS s
JOIN products AS p
	ON s.product_id = p.id
GROUP BY name
WHERE YEAR(subscription_start_date) = 2024 AND MONTH(subscription_start_date) < 4
ORDER BY total_sales DESC
LIMIT 1;

-- repeat for volume

SELECT name, COUNT(subscription_cost) AS total_sold
FROM sales AS s
JOIN products AS p
	ON s.product_id = p.id
GROUP BY name
WHERE YEAR(subscription_start_date) = 2024 AND MONTH(subscription_start_date) < 4
ORDER BY total_sold DESC
LIMIT 1;

-- JOIN sales TO sales_representatives ON s.sales_rep_id = s_r.id
-- NEW_COLUMN: first_quarter_sales -- deals made in the first 3 months of there job
	-- COUNT(subscription_start_date) 
    -- FILTER: hire_date + 3 months
-- NEW_COLUMN: first_year_sales -- deals made in the first year of job
	-- COUNT(subscription_start_date) 
    -- FILTER: hire_date + 1 year
-- OUTPUT: name, first_quarter_deals, first_year_deals
-- ORDER BY: name ASC

SELECT name, 
COUNT(IF(subscription_start_date < DATE_ADD(hire_date, INTERVAL 3 MONTH), 1, NULL)) AS first_quarter_deals
COUNT(IF(subscription_start_date < DATE_ADD(hire_date, INTERVAL 1 YEAR), 1, NULL)) AS first_year_deals
FROM sales s
JOIN sales_representatives s_r
	ON s.sales_rep_id = s_r.id
GROUP BY name
ORDER BY name