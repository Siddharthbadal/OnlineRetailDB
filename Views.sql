-- Implementing Views 

-- View for products with categories 
CREATE VIEW vw_productdetails AS
SELECT p.ProductID, p.ProductName, c.CategoryName, p.ListPrice, p.Stock
	FROM Products p
	JOIN ProductCategory c
	ON p.CategoryID = c.CategoryID;

-- Run above view
SELECT * FROM vw_productdetails;

-- View for customers Summary with products
CREATE VIEW  vw_customerorders AS
SELECT c.FirstName, c.LastName, COUNT(o.orderID) AS TotalOrder,
	SUM(o.TotalAmount) AS TotalQuantity
FROM Customers c 
JOIN Orders o
ON c.CustomerID = o.CustomerID 
GROUP BY c.FirstName, c.LastName;


SELECT * FROM vw_customerorders;


-- Summary of orderes placed in last 7 days 
CREATE VIEW  vw_recent_ordersummary AS
SELECT  o.orderID, o.orderdate, o.customerId, c.firstname, c.lastname,
	sum(oi.Quantity) as TotalProducts,
	SUM(o.TotalAmount) AS TotalQuantity
FROM Customers c 
JOIN Orders o
ON c.CustomerID = o.CustomerID 
JOIN OrderItems oi 
ON o.OrderID = oi.OrderID
GROUP BY o.orderID, o.orderdate, o.customerId, c.firstname, c.lastname;