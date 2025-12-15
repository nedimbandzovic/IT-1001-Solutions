USE classicmodels;

#Task 1

SELECT productName, buyPrice FROM products WHERE buyPrice > (SELECT AVG(buyPrice) FROM products);

#Task 2

SELECT customerName, creditLimit FROM customers WHERE creditLimit > (SELECT AVG(creditLimit) FROM customers)

#Task 3

SELECT customerName FROM customers WHERE city IN (SELECT city FROM customers GROUP BY city HAVING COUNT(*)>=2)

#Task 4

SELECT orderNumber, status FROM orders WHERE status = (
    SELECT status FROM orders
    GROUP BY status
    ORDER BY COUNT(*) DESC
    LIMIT 1
)

#Task 5

SELECT productName, quantityInStock FROM products WHERE quantityInStock > (
    SELECT AVG(quantityInStock) FROM products
    )

#Task 6

SELECT c.customerName FROM customers c
WHERE EXISTS (
    SELECT 1 FROM orders o WHERE o.customerNumber = c.customerNumber
)
ORDER BY c.customerName;

#Task 7

SELECT customerNumber, customerName FROM customers
WHERE customerNumber IN (
    SELECT o.customerNumber FROM orders o
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
    JOIN products p ON od.productCode = p.productCode
    GROUP BY o.customerNumber
    HAVING COUNT(DISTINCT p.productLine) > 1
)

#Task 8

SELECT officeCode, city FROM offices
WHERE country IN (
    SELECT DISTINCT country FROM customers
)
ORDER BY officeCode;

#Task 9

SELECT e.employeeNumber,e.firstName,e.lastName,e.officeCode
FROM employees e
WHERE e.officeCode = (
    SELECT officeCode FROM employees
    GROUP BY officeCode
    ORDER BY COUNT(*) DESC
    LIMIT 1
)
ORDER BY e.employeeNumber;

#Task 10

SELECT productName, productLine
FROM products
WHERE productLine = (
    SELECT productLine FROM products
    GROUP BY productLine
    ORDER BY COUNT(*) DESC
    LIMIT 1
)

#Task 11

SELECT e.employeeNumber, e.firstName, e.lastName FROM employees e
WHERE NOT EXISTS (
    SELECT 1 FROM customers c
    WHERE c.salesRepEmployeeNumber = e.employeeNumber
)

#Task 12

SELECT c.customerNumber, c.customerName FROM customers c
WHERE NOT EXISTS (
    SELECT 1 FROM orders o WHERE o.customerNumber = c.customerNumber
)

#Task 13

SELECT e.employeeNumber, e.firstName, e.lastName FROM employees e
WHERE e.employeeNumber IN (
    SELECT c.salesRepEmployeeNumber FROM customers c
    WHERE c.salesRepEmployeeNumber IS NOT NULL
    GROUP BY c.salesRepEmployeeNumber
    HAVING COUNT(DISTINCT c.country) > 1
)
ORDER BY e.employeeNumber;

#Task 14

SELECT customerNumber, customerName FROM customers
WHERE customerNumber IN (
    SELECT o.customerNumber FROM orders o
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
    JOIN products p ON od.productCode = p.productCode
    GROUP BY o.customerNumber
    HAVING COUNT(DISTINCT p.productLine) > 5
)

#Task 15

SELECT p.productCode FROM products p
WHERE NOT EXISTS (
    SELECT 1 FROM orderdetails od
    WHERE od.productCode = p.productCode
)

#Task 16

SELECT AVG(t.order_count) AS avg_orders_per_customer FROM (
    SELECT o.customerNumber, COUNT(DISTINCT o.orderNumber) AS order_count
    FROM orders o
    WHERE o.customerNumber IN (
        SELECT DISTINCT o2.customerNumber FROM orders o2
        JOIN orderdetails od2 ON o2.orderNumber = od2.orderNumber
        JOIN products p2      ON od2.productCode = p2.productCode
        WHERE p2.buyPrice > (
            SELECT AVG(p3.buyPrice) FROM products p3
        )
    )
    GROUP BY o.customerNumber
) AS t;

#Task 17

SELECT c.customerName FROM customers c
WHERE (
    SELECT SUM(od.quantityOrdered * od.priceEach)
    FROM orders o
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
    WHERE o.customerNumber = c.customerNumber
) > (
    SELECT AVG(customer_total)
    FROM (
        SELECT SUM(od.quantityOrdered * od.priceEach) AS customer_total
        FROM orders o
        JOIN orderdetails od ON o.orderNumber = od.orderNumber
        GROUP BY o.customerNumber
    ) t
)
ORDER BY c.customerName;

#Task 18

SELECT e.firstName,e.lastName,o.city AS officeCity, t.total_sales FROM employees e
JOIN offices o ON e.officeCode = o.officeCode
JOIN (
    SELECT c.salesRepEmployeeNumber AS employeeNumber, SUM(od.quantityOrdered * od.priceEach) AS total_sales FROM customers c
    JOIN orders ord ON c.customerNumber = ord.customerNumber
    JOIN orderdetails od ON ord.orderNumber = od.orderNumber
    WHERE c.salesRepEmployeeNumber IS NOT NULL
    GROUP BY c.salesRepEmployeeNumber
) t
    ON e.employeeNumber = t.employeeNumber
WHERE t.total_sales = (
    SELECT MAX(total_sales)
    FROM (
        SELECT SUM(od.quantityOrdered * od.priceEach) AS total_sales FROM customers c
        JOIN orders ord ON c.customerNumber = ord.customerNumber
        JOIN orderdetails od ON ord.orderNumber = od.orderNumber
        WHERE c.salesRepEmployeeNumber IS NOT NULL
        GROUP BY c.salesRepEmployeeNumber
    ) x
);

