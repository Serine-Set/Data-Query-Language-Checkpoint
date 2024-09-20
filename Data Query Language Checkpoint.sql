-- Create Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    ProductType VARCHAR(50),
    Price DECIMAL(10, 2)
);

-- Create Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15)
);

-- Create Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create OrderDetails Table
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Create ProductTypes Table
CREATE TABLE ProductTypes (
    ProductTypeID INT PRIMARY KEY,
    ProductTypeName VARCHAR(50)
);

-- Insert Records into Products Table
INSERT INTO Products (ProductID, ProductName, ProductType, Price) VALUES
(1, 'Widget A', 'Widget', 10.00),
(2, 'Widget B', 'Widget', 15.00),
(3, 'Gadget X', 'Gadget', 20.00),
(4, 'Gadget Y', 'Gadget', 25.00),
(5, 'Doohickey Z', 'Doohickey', 30.00);

-- Insert Records into Customers Table
INSERT INTO Customers (CustomerID, CustomerName, Email, Phone) VALUES
(1, 'John Smith', 'john@example.com', '123-456-7890'),
(2, 'Jane Doe', 'jane.doe@example.com', '987-654-3210'),
(3, 'Alice Brown', 'alice.brown@example.com', '456-789-0123');

-- Insert Records into Orders Table
INSERT INTO Orders (OrderID, CustomerID, OrderDate) VALUES
(101, 1, '2024-05-01'),
(102, 2, '2024-05-02'),
(103, 3, '2024-05-01');

-- Insert Records into OrderDetails Table
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity) VALUES
(1, 101, 1, 2),
(2, 101, 3, 1),
(3, 102, 2, 3),
(4, 102, 4, 2),
(5, 103, 5, 1);

-- Insert Records into ProductTypes Table
INSERT INTO ProductTypes (ProductTypeID, ProductTypeName) VALUES
(1, 'Widget'),
(2, 'Gadget'),
(3, 'Doohickey');

-- retrieve tables 
SELECT * FROM Products;
SELECT * FROM Customers;
SELECT * FROM OrderDetails;
SELECT * FROM Orders;
SELECT * FROM ProductTypes;

-- Retrieve the names of the products that have been ordered by at least one customer, along with the total quantity of each product ordered.
select P.Productname, sum (OD.Quantity) as productquantity 
from Products P
join OrderDetails OD
on P.ProductID = OD.productID
group by P.productname
having sum (OD.Quantity) > 0;


--Retrieve the names of the customers who have placed an order on every day of the week, along with the total number of orders placed by each customer
select C.CustomerName, sum (O.OrderID) as totalorders 
from Customers C
join Orders O 
on C .CustomerID = O.CustomerID
group by CustomerName
having count (O.OrderDate) = 7



--Retrieve the names of the customers who have placed the most orders, along with the total number of orders placed by each customer.
select C.CustomerName, count(O.OrderID) as totalorders
from Customers C
join Orders O 
on C.CustomerID = O.CustomerID
group by CustomerName
order by totalorders DESC




--Retrieve the names of the products that have been ordered the most, along with the total quantity of each product ordered.
select P.ProductName, sum(OD.Quantity) as productquantityordred 
from Products P
join OrderDetails OD
on P.ProductID = OD.ProductID
group by ProductName
order by productquantityordred desc


-- Retrieve the names of customers who have placed an order for at least one widget.
select CustomerName
from Customers
join products on CustomerID = ProductID
where ProductType = 'widget' 
group by CustomerName


--Retrieve the names of customers who have placed an order for at least one widget and at least one gadget, 
--along with the total cost of the widgets and gadgets ordered by each customer.
select C.CustomerName, sum (P.Price*OD.Quantity) as totalprice
from Customers C
join Orders O on C.CustomerID = O.CustomerID
join OrderDetails OD on OD.OrderID = O.OrderID
join Products P on OD.ProductID = P.ProductID
where P.ProductType in ('widget', 'gadget')
group by customername 
order by totalprice 


--Retrieve the names of the customers who have placed an order for at least one gadget, 
--along with the total cost of the gadgets ordered by each customer.
select C.CustomerName, sum(P.Price*OD.Quantity) as totalcost
from Customers C
join Orders O on C.CustomerID = O.CustomerID
join OrderDetails OD on OD.OrderID = O.OrderID
join Products P on OD.ProductID = P.ProductID
where P.ProductType = 'gadget'
group by C.CustomerName




--Retrieve the total number of widgets and gadgets ordered by each customer, along with the total cost of the orders.
select C.CustomerName, sum (OD.quantity) as totalquatity, sum ( P.price * OD.quantity)
from Customers C
join Orders O on C.CustomerID = O.CustomerID
join OrderDetails OD on OD.OrderID = O.OrderID
join Products P on OD.ProductID = P.ProductID
where producttype in ('widget', 'gadget')
group by C.CustomerName 




