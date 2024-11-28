USE RetailDBOnline;

-- Data Insertion 
-- Insert data in category table

INSERT INTO ProductCategory(CategoryName, Description)
			VALUES ('Bikes', 'Bikes and Gadgets'),
			('Books', 'Books and reading material'),
			('Clothing', 'tShirts, Pants, joggers, Socks, hoodi'),
			('Accessories', 'Other Items, Helmets, Caps') ;


-- Products
INSERT INTO Products(ProductName, CategoryID, StandardCost, ListPrice, Inhouse, Stock)
 VALUES('LG Phone', 4,59, 69, 'no', 5),
		('Dell Laptop', 4,98,120,'no',4),
		('Red TShirt', 3, 19,24, 'yes',25),
		('Bro Helmet',1,49,59,'yes',50),
		('Ride Jacket', 1, 140,240,'yes',22),
		('Harry Potter V',2, 5,9,'no',35);
		

-- Customers
INSERT INTO Customers(FirstName, LastName, Email, Contact)
VALUES('Jhon','travis','jhon.travis@gmail.com','012-2563256'),
		('Adam','Jampa','adam.jampa@gmail.com', '024-8597456')


-- if addressId not updated in customers table
-- Update Customers SET AddressID=2 where CustomerID=2
--UPDATE Address SET CustomerID=3 where AddressID=2;
--UPDATE Customers SET AddressID=1 where CustomerID=2;


-- Address
INSERT INTO Address(CustomerID ,Addressline1, Addressline2, Area, City,State, Zipcode, Country)
	VALUES(1,'123 Main Street', 'Blue Line','Main Area', 'Delhi','DLI','110024','India'),
		(2, 'House No 14Th','Yellow Line','Sector 54','Center Delhi','DLI','110045','India');



INSERT INTO Orders(CustomerID, OrderDate, TotalAmount, OrderFrom, PaymentMode)
	VALUES(1, GETDATE(), 48, 'yes','card'),
			(1, GETDATE(), 240, 'yes', 'card'),
			(2, GETDATE(), 323, 'yes','upi');

INSERT INTO OrderItems(OrderID, ProductID,Quantity,Price)
	VALUES(1, 3, 2, 48),
			(2,5,1,240),
			(3,5,1,240),
			(3,3,1,24),
			(3,4,1,59)