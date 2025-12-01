--Task 1

-- Create a query that will show the product code, product name, quantity in stock, and status (in stock or out of stock) for each product. Use a LEFT JOIN between the products and orderdetails tables to determine the quantity sold. Order the results alphabetically by product name. Make sure you do not display duplicate products. 

SELECT p.productCode, p.productName, p.quantityInStock,
    CASE
        WHEN p.quantityInStock > 0 THEN 'In Stock'
        ELSE 'Out of Stock'
    END AS status
FROM products p
LEFT JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productCode, p.productName, p.quantityInStock
ORDER BY p.productName;

--Task 2

SELECT DISTINCT c.customerName FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
WHERE YEAR(o.orderDate) = 2023

UNION

SELECT DISTINCT c.customerName FROM customers c
JOIN payments p ON c.customerNumber = p.customerNumber
WHERE YEAR(p.paymentDate) = 2005;

-- Task 14

SELECT c.customerName,c.contactFirstName,c.contactLastName,c.phone,p.amount,p.paymentDate FROM customers c
JOIN payments p ON c.customerNumber = p.customerNumber
ORDER BY p.paymentDate DESC;

-- Task 15

SELECT e.employeeNumber, e.firstName, e.lastName, IFNULL(od.quantityOrdered * od.priceEach, 0) AS total_sales
FROM employees e
LEFT JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN orders o ON c.customerNumber = o.customerNumber
LEFT JOIN orderdetails od ON o.orderNumber = od.orderNumber
ORDER BY total_sales DESC;

--Task 16

SELECT c.customerName, c.country, o.orderNumber, o.orderDate FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
ORDER BY o.orderDate DESC;

--Task 17

SELECT p.productName,p.productLine,p.quantityInStock, p.buyPrice FROM products p
JOIN productlines pl ON p.productLine = pl.productLine
ORDER BY p.productLine ASC;

-- Task 18

SELECT c.customerName,o.orderNumber,o.status,o.orderDate FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
ORDER BY o.status ASC;

-- Task 19

SELECT customerName
FROM customers
WHERE country = 'USA'

UNION

SELECT customerName
FROM customers
WHERE creditLimit > 50000;

-- Task 20

SELECT DISTINCT c.customerName FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN payments p ON c.customerNumber = p.customerNumber;

-- Task 21

SELECT c.customerName FROM customers c
LEFT JOIN payments p ON c.customerNumber = p.customerNumber
WHERE p.customerNumber IS NULL;