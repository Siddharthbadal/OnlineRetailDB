USE RetailDBOnline;
-- retrive all orders for customer id 1	
SELECT o.OrderID, o.OrderDate, o.TotalAmount,
		oi.OrderItemID ,oi.ProductID, oi.Quantity, oi.Price,
		p.ProductName
FROM Orders o
JOIN OrderItems oi 
ON o.OrderID=o.OrderID
JOIN Products p 
ON oi.ProductID = p.ProductID
WHERE o.CustomerID=2
ORDER BY oi.OrderItemID;

-- total sales of each product
SELECT p.ProductID, p.ProductName, sum(oi.quantity * oi.price) as TotalSales
FROM Products p
JOIN OrderItems oi
ON p.ProductID = oi.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalSales;

-- average order value 
SELECT AVG(TotalAmount) as AVGOrderValue FROM orders;

-- order value above average
SELECT * 
FROM orders
WHERE TotalAmount > (SELECT AVG(TotalAmount) as AVGOrderValue FROM orders);

-- top customers by total spending 
SELECT c.CustomerID, c.FirstName, c.LastName, sum(o.TotalAmount) as Total
FROM Customers c
JOIN orders o 
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY Total desc	

-- top product category
SELECT pc.CategoryID, pc.CategoryName, sum(oi.Quantity) as q
FROM ProductCategory pc 
JOIN Products p 
ON pc.CategoryID = p.CategoryID
JOIN OrderItems oi 
ON p.ProductID = oi.ProductID
GROUP BY pc.CategoryID, pc.CategoryName;

-- check if any product is out of stcok
SELECT ProductName, Stock
FROM Products
WHERE stock = 0;

-- customers with orders placed in last 7 days
SELECT  c.CustomerID, c.FirstName, c.LastName, c.Email, c.Contact
FROM Customers c 
JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE o.OrderDate >= DATEADD(DAY, -8, GETDATE()) 

-- Total numbers of orders placed each month
SELECT YEAR(OrderDate) AS Year,
		MONTH(OrderDate) AS Month, 
		COUNT(orderId) AS Total_Orders
FROM Orders 
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY 3;

-- Most recent order 
SELECT TOP 2 c.FirstName, c.LastName, o.OrderDate, o.OrderID, o.TotalAmount
FROM orders o 
JOIN Customers c
on o.CustomerID = c.CustomerID
ORDER BY o.OrderDate DESC;

-- Average Price of products in category
SELECT pc.CategoryName, AVG(p.ListPrice) AS AvgPrice
FROM Products p 
JOIN ProductCategory pc 
ON p.CategoryID = pc.CategoryID
GROUP BY pc.CategoryName

-- customers who have never placed any order 
SELECT c.FirstName, c.LastName, o.OrderID
FROM Customers c 
LEFT JOIN Orders o 
ON c.CustomerID = o.CustomerID
WHERE o.OrderID is null;

-- Total quantity sold for each products 
SELECT p.ProductName, SUM(oi.Quantity) as TotalQuantity
FROM Products p 
JOIN OrderItems oi 
ON p.ProductID = oi.ProductID
GROUP BY p.ProductName
ORDER BY 2 DESC;

-- revenue by each category 
SELECT pc.CategoryID, pc.CategoryName, SUM(oi.Price * oi.Quantity) as TotalRevenue
FROM Products p 
JOIN OrderItems oi 
ON p.ProductID = oi.ProductID
JOIN ProductCategory pc 
ON p.CategoryID = pc.CategoryID
GROUP BY pc.CategoryID, pc.CategoryName




























