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

-- check if any product is out of stock
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

-- Highest Priced product in each category with product details
SELECT CategoryName, p1.ProductName, p1.ListPrice
FROM ProductCategory pc 
JOIN Products p1 
ON pc.CategoryID = p1.CategoryID
WHERE p1.ListPrice = (	SELECT max(Listprice) 
						from Products p2 
						where p1.CategoryID = p2.CategoryID
					 );

-- find orders above $200 value
SELECT c.FirstName, c.LastName, o.OrderDate, o.OrderID, o.TotalAmount
FROM Orders o 
JOIN Customers c
ON o.CustomerID = c.CustomerID
WHERE TotalAmount > 200;




-- products with their total orders
SELECT p.ProductName, count(o.orderId) AS Number_of_orders
FROM Products p 
JOIN OrderItems o 
ON p.ProductID = o.ProductID
GROUP BY p.ProductName

-- find top three most frequent orders 
SELECT TOP 2 p.ProductName, COUNT(o.OrderID) as orderCount
FROM products p
JOIN OrderItems o 
ON p.ProductID = o.ProductID
GROUP BY p.ProductName
ORDER BY 2 desc;


-- customers from a perticular state 
SELECT a.State, COUNT(a.addressID) as total
FROM Customers c
JOIN Address a
ON c.AddressID = a.AddressID
GROUP BY a.State

-- customers with total spending 
SELECT c.CustomerID, c.FirstName, c.LastName, SUM(o.TotalAmount) as Total
FROM Customers c
JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName

-- list orders with multiple items 
SELECT o.OrderID, COUNT(oi.OrderItemID) AS TotalItems
FROM Orders o 
JOIN OrderItems oi 
ON o.OrderID = oi.OrderID
GROUP BY  o.OrderID
HAVING COUNT(oi.OrderItemID) >1
ORDER BY COUNT(oi.OrderItemID) DESC;


-- Queries with Views

select * from products;
-- Products with all category 
SELECT *
	FROM vw_productdetails;

-- producst with price range 
SELECT *
	FROM vw_productdetails
	WHERE ListPrice BETWEEN 50 AND 250;

-- Products in category
SELECT count(productId), categoryname
	FROM vw_productdetails	
	GROUP BY categoryname

-- customers with more than one order	
SELECT *
FROM vw_customerorders
WHERE TotalOrder > 1;


-- customers and total spending
SELECT FirstName, LastName, TotalAmount
FROM vw_customerorders

-- recent orders
SELECT *
	FROM vw_recent_ordersummary






































