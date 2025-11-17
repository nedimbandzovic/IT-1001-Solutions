-- Task 1
SELECT customerName, country
FROM customers
WHERE country IN ('France', 'USA');

-- Task 2
SELECT customerNumber, customerName, addressLine1, addressLine2, city, state, postalCode, country
FROM customers
WHERE contactFirstName LIKE '__%ne ';

-- Task 3
SELECT orderNumber, orderDate, customerNumber, status
FROM orders
WHERE orderDate > '2004-12-31';

-- Task 4
SELECT DISTINCT city
FROM customers;

-- Task 5
SELECT * 
FROM orders 
WHERE status IN ('Shipped', 'Resolved');

-- Task 6
SELECT * 
FROM employees 
WHERE jobTitle IN ('Sales Rep', 'Sales Manager');

-- Task 7
SELECT customerNumber, customerName, country 
FROM customers 
WHERE country IN ('Canada', 'Australia');

-- Task 8
SELECT productCode, productName 
FROM products 
WHERE MSRP > 100;

-- Task 9
SELECT orderNumber, orderDate, requiredDate 
FROM orders 
WHERE DATEDIFF(requiredDate, orderDate) >= 7;

-- Task 10
SELECT productLine 
FROM productlines 
WHERE productLine LIKE '%Classic%';

-- Task 11
SELECT customerName, creditLimit 
FROM customers 
WHERE creditLimit > 100000 
ORDER BY creditLimit DESC;

-- Task 12
SELECT employeeNumber, lastName, firstName, officeCode, jobTitle 
FROM employees 
WHERE jobTitle <> 'Sales Rep' AND officeCode = '4';

-- Task 13
SELECT productCode, productName, MSRP 
FROM products 
WHERE productName LIKE '%Mercedes%' AND MSRP < 100;

-- Task 14
SELECT customerNumber, customerName, contactLastName 
FROM customers 
WHERE contactLastName LIKE '%y';

-- Task 15
SELECT orderNumber, status 
FROM orders 
WHERE status IN ('In Process', 'On Hold');

-- Task 16
SELECT orderNumber, orderDate, customerNumber, status
FROM orders
WHERE orderDate BETWEEN '2003-01-13' AND '2004-06-09'
  AND status != 'Cancelled';

-- Task 17
SELECT orderNumber, orderDate, customerNumber, status
FROM orders
WHERE customerNumber IN (103, 112, 114);

-- Task 18
SELECT productCode, quantityOrdered
FROM orderdetails
ORDER BY quantityOrdered DESC;

-- Task 19
SELECT customerNumber, checkNumber, paymentDate, amount
FROM payments
WHERE amount > 5000;

-- Task 20
SELECT * 
FROM customers 
WHERE country = 'Germany';

-- Task 21
SELECT customerNumber, customerName, phone 
FROM customers 
WHERE creditLimit < 50000;

-- Task 22
SELECT * 
FROM orders 
WHERE status = 'On Hold';

-- Task 23
SELECT customerName 
FROM customers 
WHERE customerName LIKE 'A%';

-- Task 24
SELECT * 
FROM products 
WHERE productScale = '1:18';

-- Task 25
SELECT * 
FROM payments 
WHERE amount BETWEEN 5000 AND 10000 AND checkNumber LIKE "H%";

-- Task 26
SELECT productName, MSRP 
FROM products 
WHERE MSRP > 200 AND productName  LIKE "%1%";

-- Task 27
SELECT customerName, contactFirstName 
FROM customers 
WHERE contactFirstName LIKE 'M%' AND customerName LIKE "%Co.";

-- Task 28
SELECT * 
FROM employees 
WHERE officeCode = '1';

-- Task 29
SELECT * 
FROM orders 
WHERE YEAR(orderDate) = 2003 AND status <> "Cancelled";

-- Task 30
SELECT * 
FROM offices 
WHERE country <> 'USA' AND city LIKE "%y%";









