-- =====================================
-- DATABASE
-- =====================================
DROP DATABASE IF EXISTS bytebazaar;
CREATE DATABASE bytebazaar;
USE bytebazaar;

-- =====================================
-- DIMENSION TABLES
-- =====================================

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    category VARCHAR(100),
    sub_category VARCHAR(100),
    brand VARCHAR(100),
    price DECIMAL(10,2)
);

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    full_name VARCHAR(200),
    gender VARCHAR(10),
    age INT,
    city VARCHAR(100),
    state VARCHAR(100),
    registration_date DATE
);

CREATE TABLE Location (
    location_id INT PRIMARY KEY,
    city VARCHAR(100),
    state VARCHAR(100),
    region VARCHAR(50)
);

CREATE TABLE Date_Dim (
    date_id DATE PRIMARY KEY,
    year INT,
    month INT,
    month_name VARCHAR(20),
    day INT
);

CREATE TABLE Vendors (
    vendor_id INT PRIMARY KEY,
    vendor_name VARCHAR(100),
    city VARCHAR(100)
);

-- =====================================
-- FACT TABLE (AUTO-INCREMENT FIX)
-- =====================================
CREATE TABLE Sales (
    sales_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,

    product_id INT,
    customer_id INT,
    vendor_id INT,
    location_id INT,
    order_date DATE,

    quantity INT,
    unit_price DECIMAL(10,2),
    total_amount DECIMAL(10,2),
    delivery_status VARCHAR(50),
    payment_mode VARCHAR(50),
    profit DECIMAL(10,2),

    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (vendor_id) REFERENCES Vendors(vendor_id),
    FOREIGN KEY (location_id) REFERENCES Location(location_id),
    FOREIGN KEY (order_date) REFERENCES Date_Dim(date_id)
);

-- =====================================
-- INSERT DATA
-- =====================================

INSERT INTO Products VALUES
(101,'Laptop Pro X','Electronics','Laptops','Dell',1200),
(102,'Smartphone Z Flip','Electronics','Smartphones','Samsung',800),
(103,'Wireless Headphones','Electronics','Audio','Sony',150),
(104,'Gaming Mouse RGB','Electronics','Peripherals','Logitech',60),
(105,'Smart TV 55-inch','Electronics','Television','LG',950),
(106,'External SSD 1TB','Electronics','Storage','SanDisk',100),
(107,'Webcam HD','Electronics','Accessories','HP',45),
(108,'Smartwatch Elite','Electronics','Wearables','Apple',250),
(109,'Tablet Max','Electronics','Tablets','Lenovo',400),
(110,'Bluetooth Speaker Mini','Electronics','Audio','JBL',70);

INSERT INTO Customers VALUES
(1,'Amit Sharma','Male',28,'Hyderabad','Telangana','2024-01-10'),
(2,'Priya Singh','Female',32,'Mumbai','Maharashtra','2024-01-15'),
(3,'Rahul Verma','Male',26,'Delhi','Delhi','2024-02-01'),
(4,'Deepa Gupta','Female',30,'Bangalore','Karnataka','2024-02-10'),
(5,'Kumar Reddy','Male',35,'Chennai','Tamil Nadu','2024-02-20');

INSERT INTO Location VALUES
(1,'Hyderabad','Telangana','South'),
(2,'Mumbai','Maharashtra','West'),
(3,'Delhi','Delhi','North'),
(4,'Bangalore','Karnataka','South'),
(5,'Chennai','Tamil Nadu','South');

INSERT INTO Date_Dim VALUES
('2025-07-01',2025,7,'July',1),
('2025-07-02',2025,7,'July',2),
('2025-07-03',2025,7,'July',3),
('2025-07-04',2025,7,'July',4),
('2025-07-05',2025,7,'July',5),
('2025-07-06',2025,7,'July',6),
('2025-07-07',2025,7,'July',7),
('2025-07-08',2025,7,'July',8),
('2025-07-09',2025,7,'July',9),
('2025-07-10',2025,7,'July',10);

INSERT INTO Vendors VALUES
(1,'TechTraders','Hyderabad'),
(2,'SmartZone','Mumbai'),
(3,'AudioMart','Delhi'),
(4,'GadgetWorld','Bangalore'),
(5,'DigitalHub','Chennai');

-- INSERT WITHOUT sales_id 
INSERT INTO Sales 
(order_id, product_id, customer_id, vendor_id, location_id, order_date,
 quantity, unit_price, total_amount, delivery_status, payment_mode, profit)
VALUES
(1011,101,1,1,1,'2025-07-01',2,1200,2400,'Delivered','UPI',400),
(1012,102,2,2,2,'2025-07-02',1,800,800,'Delivered','Card',120),
(1013,103,3,3,3,'2025-07-03',3,150,450,'Pending','COD',60),
(1014,104,4,4,4,'2025-07-04',2,60,120,'Delivered','UPI',20),
(1015,105,5,5,5,'2025-07-05',1,950,950,'Cancelled','Card',90);