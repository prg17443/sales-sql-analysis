--  LEVEL 1: Basic Analysis (Foundation)
-- Q1. Find total number of orders.
SELECT 
    COUNT(Order_ID) AS Total_no_Orders
FROM
    Orders;

-- Q2. Find total sales.
SELECT 
    SUM(Sales) AS Total_sales
FROM
    Orders;

-- Q3. Find total profit.
SELECT 
    SUM(profit) AS Total_profit
FROM
    Orders;

-- Q4. Find average sales per order.
SELECT 
    AVG(Sales) AS average_sales
FROM
    Orders;

-- Q4-a. Find Average order value 
SELECT 
    SUM(SALES) / COUNT(DISTINCT Order_ID) AS Average_order_Value
FROM
    Orders;


-- Q.5 Find total number of customers.
SELECT 
    COUNT(DISTINCT Customer_ID) AS Total_customer
FROM
    Orders;

-- Q6.Find total number of products.
SELECT 
    COUNT(DISTINCT Product_ID) AS Total_products
FROM
    Orders;

-- Q7. Find minimum and maximum sales.
SELECT 
    MIN(SALES) AS minimum_sales, MAX(SALES) AS maximum_sales
FROM
    Orders;

-- Q8. Find total quantity sold.
SELECT 
    SUM(Quantity) AS Total_quantity
FROM
    Orders;


--  LEVEL 2: Category & Region Analysis (GROUP BY Mastery)

-- Q9.Total sales by Region.
SELECT 
    Region, SUM(Sales) AS Total_sales
FROM
    Orders
GROUP BY Region
ORDER BY Total_sales DESC;

-- Q10. Total profit by Region.
SELECT 
    Region, SUM(Profit) AS Total_profit
FROM
    Orders
GROUP BY Region;

-- Q11. Total sales by Category.
SELECT 
    Category, SUM(Sales) AS Total_sales
FROM
    Orders
GROUP BY category;

-- Q12. Total sales by Sub-Category.
SELECT 
    Sub_category, SUM(Sales) AS Total_sales
FROM
    Orders
GROUP BY Sub_category;

-- Q13. Top 5 Sub-Categories by sales.
SELECT 
    Sub_category, SUM(Sales) AS Total_Sales
FROM
    Orders
GROUP BY Sub_category
ORDER BY Total_sales DESC
LIMIT 5;

-- Q14. Bottom 5 Sub-Categories by profit.
SELECT 
    sub_category, SUM(profit) AS Total_profit
FROM
    Orders
GROUP BY Sub_category
ORDER BY Total_profit ASC
LIMIT 5;

-- Q15. Region with highest profit.
SELECT 
    Region, SUM(profit) AS Total_profit
FROM
    Orders
GROUP BY Region
ORDER BY Total_profit DESC
LIMIT 1;

-- Q16. Category with highest average sales.
SELECT 
    category, AVG(Sales) AS Average_sales
FROM
    Orders
GROUP BY category
ORDER BY Average_sales DESC
LIMIT 1;

-- Q16 a: Highest Average Order Value per Category.(If there are duplicate in Order_ID)
SELECT 
    Category,
    SUM(Sales) / COUNT(DISTINCT Order_ID) AS Avg_Order_Value
FROM
    Orders
GROUP BY Category
ORDER BY Avg_Order_Value DESC
LIMIT 1;

-- Q17. Total sales by Ship Mode.
SELECT 
    ship_mode, SUM(Sales) AS Total_sales
FROM
    Orders
GROUP BY ship_mode;

-- LEVEL 3: Time-Based Analysis (Date Functions)
-- Q18. Total sales by Year.
SELECT 
    YEAR(Order_Date) AS Years, SUM(Sales) AS Total_SALES
FROM
    Orders
GROUP BY Years;

-- Q19. Total sales by Month.
SELECT 
    YEAR(Order_Date) AS Year,
    MONTH(Order_Date) AS Month,
    MONTHNAME(Order_Date) AS Month_Name,
    SUM(Sales) AS Total_Sales
FROM
    Orders
GROUP BY Year , Month , Month_Name
ORDER BY Year , Month;

-- Q20. Best sales month overall.
SELECT 
    YEAR(Order_Date) AS Year,
    MONTHNAME(Order_Date) AS Month_Name,
    SUM(Sales) AS Total_Sales
FROM
    Orders
GROUP BY Year , Month_Name
ORDER BY Total_Sales DESC
LIMIT 1;

-- Q21. Sales growth year over year.
SELECT Years,
       Total_sales,
       previous_year_sales,
       ROUND(
           ((Total_sales - previous_year_sales) / previous_year_sales) * 100,
           2
       ) AS YoY_Growth_Percentage
FROM (
    SELECT Years,
           Total_sales,
           LAG(Total_sales) OVER (ORDER BY Years) AS previous_year_sales
    FROM (
        SELECT YEAR(Order_Date) AS Years,
               SUM(Sales) AS Total_sales
        FROM Orders
        GROUP BY Years
    ) t
) r;

-- Q22. Profit by Year.
SELECT 
    YEAR(Order_Date) AS Years, SUM(Profit) AS Total_profit
FROM
    Orders
GROUP BY YEAR(Order_Date);

-- Q23. Find busiest month (highest number of orders).
SELECT 
    YEAR(Order_Date) AS Years,
    MONTHNAME(Order_Date) AS month_name,
    COUNT(DISTINCT Order_ID) AS number_orders
FROM
    Orders
GROUP BY Years , month_name
ORDER BY number_orders DESC
LIMIT 1;

--  LEVEL 4: Customer Analysis
-- Q24. Top 10 customers by sales.
SELECT 
    Customer_Name, SUM(Sales) AS Total_sales
FROM
    Orders
GROUP BY Customer_Name
ORDER BY Total_Sales DESC
LIMIT 10;
 
-- Q25. Top 10 customers by profit.
SELECT 
    Customer_Name, SUM(Profit) AS Total_profit
FROM
    Orders
GROUP BY Customer_Name
ORDER BY Total_profit DESC
LIMIT 10;

-- Q26. Customer who placed most orders.
SELECT 
    Customer_Name, COUNT(DISTINCT Order_ID) AS Most_Orders
FROM
    Orders
GROUP BY Customer_Name
ORDER BY Most_Orders DESC
LIMIT 1;

-- Q27. Average sales per customer.
SELECT 
    Customer_Name,
    SUM(Sales) / COUNT(DISTINCT Order_ID) AS Average_sales
FROM
    Orders
GROUP BY Customer_Name;

-- Q27. a) Average total spending per customer
SELECT 
    AVG(Total_spending) AS Avg_sales_per_customer
FROM
    (SELECT 
        customer_name, SUM(Sales) AS Total_spending
    FROM
        Orders
    GROUP BY Customer_Name) AS t;

-- Q28. Customer retention check (customers ordering more than once).
SELECT 
    Customer_Name, COUNT(DISTINCT Order_ID) AS cus_ret_check
FROM
    Orders
GROUP BY Customer_Name
HAVING cus_ret_check > 1
ORDER BY cus_ret_check DESC;

-- Q29. Find customers with negative profit.
SELECT 
    Customer_Name, SUM(Profit) AS Total_profit
FROM
    Orders
GROUP BY Customer_Name
HAVING Total_profit < 0;

--  LEVEL 5: Product Performance
-- Q30. Most sold product (by quantity).
SELECT 
    Product_Name, SUM(quantity) AS sold_quantity
FROM
    Orders
GROUP BY Product_Name
ORDER BY sold_quantity DESC
LIMIT 1; 

-- Q31. Most profitable product.
SELECT 
    Product_Name, SUM(Profit) AS profitable_product
FROM
    Orders
GROUP BY Product_Name
ORDER BY profitable_product DESC
LIMIT 1;

-- Q32. Products generating loss.
SELECT 
    Product_Name, SUM(Profit) AS Total_profit
FROM
    Orders
GROUP BY Product_Name
HAVING Total_profit < 0
ORDER BY Total_profit ASC;

-- Q33. Average discount given per category.
SELECT 
    Category, AVG(Discount) AS avg_dis
FROM
    orders
GROUP BY category;

-- Q34. Relationship between discount and profit (group by discount).
SELECT 
    Discount,
    SUM(profit) AS Total_profit,
    AVG(profit) AS Avg_profit
FROM
    Orders
GROUP BY Discount
ORDER BY Discount;
-- Note : Analysis shows that discounts above 30% lead to consistent negative profitability. The company should limit discount levels to 20% or lower to maintain sustainable margins.

-- Q35. Top 5 products in each category (Advanced).
SELECT 
	  category , 
      product_name, 
      Total_sales , 
      ranking 
FROM (
SELECT 
Category , Product_Name ,SUM(Sales) AS Total_Sales, DENSE_RANK() OVER (PARTITION BY category ORDER BY SUM(Sales) DESC) AS ranking 
FROM Orders 
GROUP BY category,product_name) AS t 
WHERE ranking <= 5 ;

-- LEVEL 6: Advanced SQL (Real Project Level)
-- Q36. Rank customers by total sales (use RANK or DENSE_RANK).
SELECT 
Customer_Name , Total_sales , 
DENSE_RANK() OVER (ORDER BY Total_sales DESC) AS Ranking 
FROM 
(SELECT 
Customer_Name , SUM(Sales) AS Total_sales 
FROM Orders 
GROUP BY Customer_Name) AS t ;

-- Q37. Running total of sales by date.
SELECT Order_Date, Daily_sales, 
SUM(Daily_Sales) OVER (ORDER BY Order_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Running_Total 
FROM 
(SELECT Order_date , 
SUM(Sales) AS Daily_Sales 
FROM Orders 
GROUP BY Order_date) AS r;

-- Q38. Percentage contribution of each region to total sales.
SELECT 
    region,
    SUM(Sales) AS Total_sales,
    CONCAT(ROUND((SUM(Sales) / (SELECT 
                            SUM(Sales)
                        FROM
                            Orders) * 100),
                    2),
            '%') AS percentage_contribution
FROM
    Orders
GROUP BY region;

-- Q39. Find duplicate orders (if any).
SELECT 
    Order_ID, Product_ID, COUNT(*) AS duplicate_count
FROM
    Orders
GROUP BY Order_ID , product_ID
HAVING COUNT(*) > 1;

-- Q40. Orders where profit is negative but sales is high.
SELECT 
    Order_ID,
    SUM(Profit) AS Total_profit,
    SUM(Sales) AS Total_sales
FROM
    Orders
GROUP BY Order_ID
HAVING Total_profit < 0
    AND Total_sales > (SELECT 
        AVG(Total_Sales)
    FROM
        (SELECT 
            SUM(Sales) AS Total_Sales
        FROM
            Orders
        GROUP BY Order_ID) AS t)
ORDER BY Total_sales DESC;

-- Q41. Find month with highest profit per year.
SELECT Years,
Month_name, 
Total_profit , rnk 
FROM (
SELECT 
YEAR(Order_Date) AS Years , 
MONTHNAME(Order_date) AS Month_name,
SUM(Profit) AS Total_profit, 
RANK() OVER (PARTITION BY YEAR(Order_date) ORDER BY SUM(Profit) DESC) AS rnk 
FROM Orders 
GROUP BY Years,Month(Order_date),Month_name) as T 
WHERE rnk = 1; 

-- Q42.  Create a view for total sales by region.
CREATE VIEW Total_sal_reg AS
    (SELECT 
        Region, SUM(Sales) AS Total_sal
    FROM
        Orders
    GROUP BY Region);

-- Q43. Create an index to optimize sales , region , Order_date , Customer_ID, Category query.
CREATE INDEX idx_sales ON Orders(Sales);
CREATE INDEX idx_region ON Orders(Region);
CREATE INDEX idx_order_date ON Orders(Order_Date);
CREATE INDEX idx_customer ON Orders(Customer_ID);
CREATE INDEX idx_category ON Orders(Category);

-- Q44. Stored procedure to get sales by region.
DELIMITER $$ 
CREATE PROCEDURE sal_reg (IN var_region VARCHAR(50))
BEGIN
SELECT 
    Region, SUM(sales) AS Total_Sales
FROM
    Orders
WHERE
    Region = var_region
GROUP BY Region;
END
 $$ DELIMITER ;
 

-- Q45. Find correlation pattern: high discount vs low profit.
SELECT 
    Discount,
    COUNT(*) AS Orders_count,
    AVG(Profit) AS Avg_profit,
    SUM(profit) AS Total_profit
FROM
    Orders
GROUP BY Discount
ORDER BY Discount;
-- Co-orelation pattern Formula
SELECT 
    (AVG(Discount * Profit) - AVG(Discount) * AVG(Profit)) / (STDDEV_POP(Discount) * STDDEV_POP(Profit)) AS Correlation_Coefficient
FROM
    Orders;

-- FINAL CHALLENGE (Resume-Level Questions)
-- Q46. Build a summary table with: i) Total Sales, ii) Total Profit, iii) Total Orders iv) Profit Margin %
SELECT 
    'Total_sales' AS 'Parameter', ROUND(SUM(Sales), 2) AS Value
FROM
    Orders 
UNION ALL SELECT 
    'Total_profit', ROUND(SUM(profit), 2)
FROM
    Orders 
UNION ALL SELECT 
    'Total_Orders', COUNT(DISTINCT Order_ID)
FROM
    Orders 
UNION ALL SELECT 
    'Profit Margin %',
    ROUND(SUM(Profit) / NULLIF(SUM(Sales), 0) * 100,
            2)
FROM
    Orders;

-- One_row_dashboard
SELECT 
    ROUND(SUM(Sales), 2) AS Total_sales,
    ROUND(SUM(profit), 2) AS Total_profit,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    ROUND(SUM(Profit) / NULLIF(SUM(Sales), 0) * 100,
            2) AS Profit_Margin
FROM
    Orders;

-- Q47. Identify underperforming categories.
SELECT 
    Category,
    SUM(Sales) AS Total_sales,
    SUM(Profit) AS Total_profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin
FROM
    Orders
GROUP BY Category
ORDER BY Profit_Margin ASC;

-- Note : Furniture has high sales but low margin , it may be underperforming operationally

-- Q48. Suggest which region to invest more in (based on profit trends).
SELECT 
    Region,
    YEAR(Order_date) AS Years,
    SUM(Profit) AS Total_profit
FROM
    Orders
GROUP BY Region , Years
ORDER BY Region , Years;

-- Note : Based on 4-year profit trends, the West region shows consistent and accelerating growth, making it the strongest candidate for further investment. 
-- The East region also demonstrates stable profitability and expansion potential. 
-- Central and South show volatility and would require operational review before capital allocation.

-- Q50. Find seasonal patterns.
SELECT 
    Month_number,
    Month_name,
    ROUND(AVG(Monthly_Sales), 2) AS Avg_Monthly_sales
FROM
    (SELECT 
        YEAR(Order_date) AS Years,
            MONTH(Order_date) AS Month_Number,
            MONTHNAME(Order_date) AS Month_name,
            SUM(Sales) AS Monthly_Sales
    FROM
        Orders
    GROUP BY Years , Month_Number , Month_name) AS t
GROUP BY Month_Number , Month_Name
ORDER BY Month_Number;

-- Note : The company demonstrates strong Q4 seasonality, with sales peaking from September through December, particularly in November. 
-- Early-year months (January–February) show significantly lower demand, indicating a post-holiday slowdown effect.

-- Write 5 business insights from the dataset.
-- The dataset reveals strong Q4 seasonality, with November being the peak revenue month. The West region demonstrates the highest and most consistent profit growth, 
-- making it the strongest candidate for expansion. However, high discount levels negatively impact profitability, indicating the need for better discount governance. 
-- Additionally, certain product categories underperform and require strategic reassessment. 
-- Overall, profit margin monitoring is essential as high sales do not always translate to high profitability.














