📊 Sales Analysis SQL Project

🚀 Overview
End-to-end SQL project analyzing transactional sales data to uncover revenue trends, profitability drivers, customer behavior, and seasonal patterns.
Built using advanced SQL techniques including window functions, ranking, correlation analysis, indexing, and stored procedures.

🛠 Tech Stack
- MySQL(8+)
- SQL (Advanced Queries)
- Window Functions (LAG, RANK, DENSE_RANK)
- Aggregate & Analytical Functions
- Views & Index Optimization

📈 Key Analysis Performed
📌 Total Sales, Profit & KPI Dashboard
📌 Year-over-Year Growth Analysis
📌 Regional & Category Performance
📌 Customer Retention & Top Customers
📌 Product Profitability & Loss Detection
📌 Discount vs Profit Correlation
📌 Seasonal Trend Analysis
📌 Running Totals & Ranking Queries

💡 Business Insights
i) Strong Q4 seasonality with peak sales in November
ii) West region shows consistent profit growth
iii) High discounts negatively impact margins
iv) High revenue does not always mean high profitability
v) Some categories underperform despite strong sales

📊 Sample Executive KPI Query
SELECT 
    ROUND(SUM(Sales), 2) AS Total_sales,
    ROUND(SUM(Profit), 2) AS Total_profit,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    ROUND(SUM(Profit) / NULLIF(SUM(Sales), 0) * 100, 2) AS Profit_Margin
FROM Orders;

🎯 Project Impact
Demonstrates strong SQL fundamentals, advanced analytical capabilities, and the ability to translate raw data into actionable business insights.

📌 Summary Version
Built an advanced SQL Sales Analysis project answering 50+ business questions using aggregations, window functions, ranking, correlation analysis, and performance optimization techniques to derive actionable insights.
