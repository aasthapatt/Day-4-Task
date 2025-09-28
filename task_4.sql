CREATE DATABASE task_4;
USE task_4;

CREATE TABLE users (
user_id INT PRIMARY KEY,
name VARCHAR(100),
email VARCHAR(150),
created_at DATE
);

CREATE TABLE categories (
category_id INT PRIMARY KEY,
name VARCHAR(100)
);

CREATE TABLE products (
product_id INT PRIMARY KEY,
name VARCHAR(150),
category_id INT,
price DECIMAL(10,2),
stock INT
);

CREATE TABLE orders (
order_id INT PRIMARY KEY,
user_id INT,
order_date DATE,
status VARCHAR(30),
total_amount DECIMAL(10,2)
);

CREATE TABLE order_items (
order_item_id INT PRIMARY KEY,
order_id INT,
product_id INT,
quantity INT,
unit_price DECIMAL(10,2)
);

CREATE TABLE payments (
payment_id INT PRIMARY KEY,
order_id INT,
payment_method VARCHAR(50),
amount DECIMAL(10,2),
payment_date DATE
);


INSERT INTO users VALUES (1,'Alice','alice@example.com','2024-01-10'),
(2,'Bob','bob@example.com','2024-02-05'),
(3,'Carol','carol@example.com','2024-03-20');

INSERT INTO categories VALUES (1,'Clothing'),(2,'Electronics');

INSERT INTO products VALUES
(10,'T-Shirt',1,299.00,150),
(11,'Jeans',1,799.00,80),
(20,'Headphones',2,1499.00,40);

INSERT INTO orders VALUES 
(100,1,'2024-06-05','delivered',598.00),
(101,2,'2024-06-15','delivered',1499.00),
(102,1,'2024-07-01','pending',1499.00),
(103,3,'2025-04-01','delivered',1499.00);

INSERT INTO order_items VALUES
(1000,100,10,2,299.00),
(1001,101,20,1,1499.00),
(1002,102,20,1,1499.00);

INSERT INTO payments VALUES
(500,100,'card',598.00,'2024-06-05'),
(501,101,'card',1499.00,'2024-06-15');


/*Step_1 : List product price > 500 ,newest first*/
SELECT product_id, name, price, stock
FROM products
WHERE price > 500
ORDER BY price DESC;

/*Step_2 : Sales by year*/
SELECT YEAR(order_date) AS year, SUM(total_amount) AS total_sales
FROM orders
GROUP BY YEAR(order_date)
ORDER BY year;

/*Step_3 : Ordered with user details*/
SELECT o.order_id, o.order_date, u.user_id, u.name, o.total_amount
FROM orders o
INNER JOIN users u ON o.user_id = u.user_id
ORDER BY o.order_date;

/*Step_4 : Find unpaid orders*/
SELECT o.order_id, o.user_id, p.payment_id
FROM orders o
LEFT JOIN payments p ON o.order_id = p.order_id
WHERE p.payment_id IS NULL;

/*Step_5 : Find all payment and order related info*/
SELECT p.payment_id, p.amount, o.order_id, o.total_amount
FROM payments p
RIGHT JOIN orders o ON p.order_id = o.order_id;

/*Step_6 : Product price above average*/
SELECT product_id, name, price
FROM products
WHERE price > (SELECT AVG(price) FROM products);

/*Step_7 : Sum of sales by users and only show users with sales > 1000*/
SELECT user_id, SUM(total_amount) AS total_sales
FROM orders
GROUP BY user_id
HAVING SUM(total_amount) > 1000;

