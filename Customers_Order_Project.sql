CREATE DATABASE Customers_Orders_Products 

CREATE TABLE Customers (
  CustomerID INT PRIMARY KEY,
  Name VARCHAR(50),
  Email VARCHAR(100)
)

INSERT INTO Customers (CustomerID, Name, Email)
VALUES
  (1, 'John Doe', 'johndoe@example.com'),
  (2, 'Jane Smith', 'janesmith@example.com'),
  (3, 'Robert Johnson', 'robertjohnson@example.com'),
  (4, 'Emily Brown', 'emilybrown@example.com'),
  (5, 'Michael Davis', 'michaeldavis@example.com'),
  (6, 'Sarah Wilson', 'sarahwilson@example.com'),
  (7, 'David Thompson', 'davidthompson@example.com'),
  (8, 'Jessica Lee', 'jessicalee@example.com'),
  (9, 'William Turner', 'williamturner@example.com'),
  (10, 'Olivia Martinez', 'oliviamartinez@example.com');

  CREATE TABLE Orders (
  OrderID INT PRIMARY KEY,
  CustomerID INT,
  ProductName VARCHAR(50),
  OrderDate VARCHAR(MAX),
  Quantity INT
);

INSERT INTO Orders (OrderID, CustomerID, ProductName, OrderDate, Quantity)
VALUES
  (1, 1, 'Product A', '2023-07-01', 5),
  (2, 2, 'Product B', '2023-07-02', 3),
  (3, 3, 'Product C', '2023-07-03', 2),
  (4, 4, 'Product A', '2023-07-04', 1),
  (5, 5, 'Product B', '2023-07-05', 4),
  (6, 6, 'Product C', '2023-07-06', 2),
  (7, 7, 'Product A', '2023-07-07', 3),
  (8, 8, 'Product B', '2023-07-08', 2),
  (9, 9, 'Product C', '2023-07-09', 5),
  (10, 10, 'Product A', '2023-07-10', 1);

  CREATE TABLE Products (
  ProductID INT PRIMARY KEY,
  ProductName VARCHAR(50),
  Price DECIMAL(10, 2)
);

INSERT INTO Products (ProductID, ProductName, Price)
VALUES
  (1, 'Product A', 10.99),
  (2, 'Product B', 8.99),
  (3, 'Product C', 5.99),
  (4, 'Product D', 12.99),
  (5, 'Product E', 7.99),
  (6, 'Product F', 6.99),
  (7, 'Product G', 9.99),
  (8, 'Product H', 11.99),
  (9, 'Product I', 14.99),
  (10, 'Product J', 4.99);

  SELECT * FROM Customers
  SELECT * FROM Orders
  SELECT * FROM Products
   
---------------------TASK-1--------------------

-----------------------1-----------------------
--1.	Write a query to retrieve all records from the Customers table
SELECT * FROM Customers

-----------------------2-----------------------
--2.	Write a query to retrieve the names and email addresses of customers whose names start with 'J'.
SELECT Name,Email
FROM Customers
WHERE NAME LIKE 'J%'

-----------------------3-----------------------
--3.	Write a query to retrieve the order details (OrderID, ProductName, Quantity) for all orders..
SELECT OrderID,ProductName,Quantity
FROM Orders

-----------------------4-----------------------
--4.	Write a query to calculate the total quantity of products ordered.
SELECT SUM(Quantity) AS 'TOTAL QUANTITY'
FROM Orders

-----------------------5-----------------------
--5.	Write a query to retrieve the names of customers who have placed an order.
SELECT Name
FROM Customers
WHERE CustomerID IN 
( SELECT CustomerID FROM Orders WHERE OrderID IS NOT NULL )

SELECT DISTINCT C.Name
FROM Customers C
LEFT JOIN Orders O                                              
ON O.CustomerID=C.CustomerID
WHERE OrderID IS NOT NULL

SELECT Name 
FROM Customers
WHERE EXISTS (SELECT * FROM Orders WHERE Orders.CustomerID=Customers.CustomerID)

SELECT * FROM Customers
SELECT * FROM Orders
SELECT * FROM Products

-----------------------6-----------------------
--6.	Write a query to retrieve the products with a price greater than $10.00.
SELECT ProductName
FROM Products 
WHERE Price > 10.00

-----------------------7-----------------------
--7.	Write a query to retrieve the customer name and order date for all orders placed on or after '2023-07-05'.
SELECT C.Name, O.OrderDate
FROM Customers C
JOIN Orders O 
ON C.CustomerID=O.CustomerID 
WHERE OrderDate >= '2023-07-05'

-----------------------8-----------------------
--8.	Write a query to calculate the average price of all products.
SELECT AVG(Price)
FROM Products

-----------------------9-----------------------
--9.	Write a query to retrieve the customer names along with the total quantity of products they have ordered.
SELECT C.Name,SUM(O.Quantity) 'Total'
FROM Customers C 
JOIN Orders O
ON C.CustomerID=O.CustomerID
GROUP BY C.Name
ORDER BY TOTAL DESC

-----------------------10-----------------------
--10.	Write a query to retrieve the products that have not been ordered
SELECT ProductName,ProductID,Price
FROM Products
WHERE NOT EXISTS (
              SELECT * FROM Orders 
			  WHERE Orders.ProductName=Products.ProductName
			  )

SELECT * FROM Customers
SELECT * FROM Orders
SELECT * FROM Products

SELECT Products.* 
FROM Orders 
RIGHT JOIN Products 
ON Orders.ProductName=Products.ProductName 
WHERE Orders.Quantity IS NULL

Select ProductID,ProductName
FROM Products
WHERE ProductName NOT IN (SELECT ProductName FROM Orders)

---------------------TASK-2-------------

-----------------------1-----------------------
--1.	Write a query to retrieve the top 5 customers who have placed the highest total quantity of orders.
SELECT TOP 5 C.Name,SUM(O.Quantity) 'Total'
FROM Customers C 
JOIN Orders O
ON C.CustomerID=O.CustomerID
GROUP BY C.Name
ORDER BY TOTAL DESC

-----------------------2-----------------------
--2.	Write a query to calculate the average price of products for each product category.

SELECT ProductID,AVG(Price)
FROM Products
GROUP BY ProductID

-----------------------3-----------------------
--3.	Write a query to retrieve the customers who have not placed any orders.
SELECT *
FROM Customers
WHERE NOT EXISTS 
(
SELECT * 
FROM Orders 
WHERE Customers.CustomerID=Orders.CustomerID
)

SELECT C.* 
FROM Customers C LEFT JOIN
Orders O
ON C.CustomerID=O.CustomerID
WHERE O.OrderID IS NULL

-----------------------4-----------------------
--4.	Write a query to retrieve the order details (OrderID, ProductName, Quantity) for orders placed by customers whose names start with 'M'.
SELECT O.OrderID,O.ProductName,O.Quantity 
FROM Customers C LEFT JOIN
Orders O
ON C.CustomerID=O.CustomerID
WHERE C.Name LIKE 'M%'

-----------------------5-----------------------
--5.	Write a query to calculate the total revenue generated from all orders.
SELECT SUM(TotalQuantity*PricePerProduct)
FROM 
(SELECT O.ProductName,SUM(O.Quantity) 'TotalQuantity',P.Price 'PricePerProduct'
FROM Orders O LEFT JOIN 
Products P ON O.ProductName=P.ProductName
GROUP BY O.ProductName,P.Price) 
AS COM 

SELECT SUM(o.Quantity*p.Price) 
FROM Orders o
INNER JOIN Products p
ON o.ProductName=p.ProductName

-----------------------6-----------------------
--6.	Write a query to retrieve the customer names along with the total revenue generated from their orders.
select * from Products
select * from Orders
select * from Customers

SELECT c.Name,o.ProductName,o.Quantity,p.Price,(o.Quantity*p.Price) 'RevenuePerCustomer'
FROM Orders o
INNER JOIN Customers c
ON o.CustomerID=c.CustomerID
INNER JOIN Products p 
ON o.ProductName=p.ProductName

-----------------------7-----------------------
--7.	Write a query to retrieve the customers who have placed at least one order for each product category.
SELECT C.Name
FROM Orders O
INNER JOIN Customers c
ON o.CustomerID=c.CustomerID
WHERE O.Quantity IS NOT NULL

-----------------------8-----------------------
--8.	Write a query to retrieve the customers who have placed orders on consecutive days.
SELECT c.NameFROM Customers c INNER JOIN Orders o1 ON c.CustomerID = o1.CustomerID INNER JOIN Orders o2 ON c.CustomerID = o2.CustomerID WHERE DATEDIFF(DAY, o1.OrderDate, o2.OrderDate) = 1-----------------------9-------------------------9.	Write a query to retrieve the top 3 products with the highest average quantity ordered.SELECT TOP 3 ProductName,AVG(Quantity) 'Avg'FROM OrdersGROUP BY ProductNameORDER BY Avg DESC-----------------------10-------------------------10.	Write a query to calculate the percentage of orders that have a quantity greater than the average quantity.SELECT (COUNT(CASE WHEN o.Quantity > avg.Quantity THEN 1 END) * 100.0) / COUNT(*) AS Percentage FROM Orders o CROSS JOIN (SELECT AVG(Quantity) AS Quantity FROM Orders) avg---------------------TASK-3------------------------------------1-------------------------1.	Write a query to retrieve the customers who have placed orders for all products.SELECT C.NameFROM Orders OINNER JOIN Customers CON O.CustomerID=C.CustomerIDWHERE ProductName=ALL(SELECT ProductName FROM Products)----------------------2-------------------------2.	Write a query to retrieve the products that have been ordered by all customers.SELECT ProductNameFROM OrdersWHERE CustomerID=ALL(SELECT CustomerID FROM Customers)SELECT * FROM OrdersSELECT * FROM Customers-----------------------3-------------------------3.	Write a query to calculate the total revenue generated from orders placed in each month.SELECT * FROM OrdersSELECT * FROM ProductsSELECT DATEPART(month,OrderDate) 'Month' ,SUM(Quantity*Price) 'TOTAL SALE'FROM Orders OINNER JOIN Products PON O.ProductName=P.ProductNameGROUP BY DATEPART(month,OrderDate)-----------------------4-------------------------4.	Write a query to retrieve the products that have been ordered by more than 50% of the customers.SELECT p.ProductName FROM Products p INNER JOIN Orders o ON p.ProductName = o.ProductName GROUP BY p.ProductName HAVING COUNT(DISTINCT o.CustomerID) > (SELECT COUNT(*) * 0.5 FROM Customers)-----------------------5-------------------------5.	Write a query to retrieve the top 5 customers who have spent the highest amount of money on orders.SELECT TOP 5 CustomerID,SUM(TotalSale) FROM(SELECT O.CustomerID ,(O.Quantity*P.Price) 'TotalSale'FROM Orders OINNER JOIN Products PON O.ProductName=P.ProductName) AS CPOGROUP BY CustomerIDORDER BY SUM(TotalSale) DESCSELECT * FROM OrdersSELECT * FROM CustomersINSERT INTO Orders (OrderID, CustomerID, ProductName, OrderDate, Quantity)
VALUES
  (11, 1, 'Product A', '2023-07-11', 5)
DELETE Orders WHERE OrderID=11

-----------------------6-----------------------
--6.	Write a query to calculate the running total of order quantities for each customer.
SELECT CustomerID,(
SELECT SUM(O2.Quantity)
FROM Orders O2 
WHERE O2.CustomerID<=O1.CustomerID) 'RunningTotal'
FROM Orders O1
GROUP BY CustomerID

-----------------------7-----------------------
--7.	Write a query to retrieve the top 3 most recent orders for each customer.
select * from Orders
select * from Products
Select * from Customers

SELECT o.*
FROM (
  SELECT customerid, orderid, orderdate,
         ROW_NUMBER() OVER (PARTITION BY customerid ORDER BY orderdate DESC) AS row_num
  FROM orders
) o
WHERE o.row_num <= 3
ORDER BY o.customerid, o.orderdate DESC

-----------------------8-----------------------
--8.	Write a query to calculate the total revenue generated by each customer in the last 30 days.
SELECT CustomerID,SUM(TotalSale) FROM(SELECT O.CustomerID ,(O.Quantity*P.Price) 'TotalSale'FROM Orders OINNER JOIN Products PON O.ProductName=P.ProductNameWHERE DATEDIFF(Day,OrderDate,GETDATE())<=30) AS CPOGROUP BY CustomerID

INSERT INTO Orders (OrderID, CustomerID, ProductName, OrderDate, Quantity)
VALUES
  (12, 2, 'Product B', '2023-12-11', 5)

INSERT INTO Orders (OrderID, CustomerID, ProductName, OrderDate, Quantity)
VALUES
  (13, 1, 'Product C', '2023-12-12', 3)
INSERT INTO Orders (OrderID, CustomerID, ProductName, OrderDate, Quantity)
VALUES
  (14, 3, 'Product F', '2023-12-13', 1)
SELECT * FROM Orders
SELECT * FROM Products

-----------------------9-----------------------
--9.	Write a query to retrieve the customers who have placed orders for at least two different product categories.
SELECT o.CustomerID FROM Products p INNER JOIN Orders o ON p.ProductName = o.ProductName GROUP BY o.CustomerIDHAVING COUNT(DISTINCT p.ProductID) >= 2-----------------------10-------------------------10.	Write a query to calculate the average revenue per order for each customer.SELECT CustomerID, AVG(order_total) AS avg_revenue_per_order
FROM (
  SELECT O.CustomerID, O.OrderID, SUM(P.Price * O.Quantity) AS order_total
   FROM Orders O
  JOIN Products P ON O.ProductName=P.ProductName
  GROUP BY customerid, orderid
) o
GROUP BY customerid

select * from Orders
select * from Products
Select * from Customers