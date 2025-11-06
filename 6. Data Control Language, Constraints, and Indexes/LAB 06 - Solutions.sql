/*
 Task 1
 In this task you should create a MySQL database named "university".
 Following that, establish a user account titled "student" with the capability to connect from any host,
 utilizing the password "secure123".
 Next, grant the "student" user SELECT, INSERT, and UPDATE permissions for all tables within the "university" database
 to provide comprehensive access.
 Verify the "student" user's permissions to make sure they are correct and correspond with the desired access levels.
 Subsequently, revoke the UPDATE permission from the "student" user as needed to modify access privileges.
 Finally, validate the updated permissions for the "student" user to ensure successful implementation of changes.
 */

CREATE DATABASE university;
CREATE USER 'student'@'%' identified by 'secure123';
GRANT SELECT, INSERT, UPDATE ON university.* TO 'student'@'%';
# FLUSH PRIVILEGES if needed
SHOW GRANTS FOR 'student'@'%';
REVOKE UPDATE ON university.* FROM 'student'@'%';
# FLUSH PRIVILEGES if needed
SHOW GRANTS FOR 'student'@'%';

/*
 Task 2
 Design and create a MySQL database named "company" to serve as the foundation for the company management system.
 Design and implement at least six tables within the "company" database,
 each serving a distinct purpose related to company operations.
 Ensure that appropriate constraints are applied to maintain data integrity and enforce business rules within each table.
 Implement constraints specific to the business requirements of the company, such as ensuring uniqueness of employee IDs
 or enforcing minimum and maximum values for certain attributes.
 Verify the successful implementation of constraints by reviewing the table structure and constraints within the database.
 */
CREATE DATABASE company;
USE company;
CREATE TABLE departments (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) UNIQUE NOT NULL
);
CREATE TABLE employees (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(100) UNIQUE,
  salary DECIMAL(10,2) CHECK (salary >= 400),
  department_id INT UNSIGNED,
  FOREIGN KEY (department_id) REFERENCES departments(id)
);
CREATE TABLE positions (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(50) NOT NULL,
  min_salary DECIMAL(10,2),
  max_salary DECIMAL(10,2),
  CHECK (min_salary >= 300),
  CHECK ( max_salary <= 5000)
);
CREATE TABLE projects (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE,
  CHECK (end_date <= '2025.11.01'),
  CHECK (start_date >= '2023.11.01')
);
CREATE TABLE employee_project (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  employee_id INT UNSIGNED,
  project_id INT UNSIGNED,
  FOREIGN KEY (employee_id) REFERENCES employees(id),
  FOREIGN KEY (project_id) REFERENCES projects(id)
);
CREATE TABLE attendance (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  employee_id INT UNSIGNED,
  date DATE NOT NULL,
  status ENUM('Present', 'Absent', 'Leave') DEFAULT 'Present',
  FOREIGN KEY (employee_id) REFERENCES employees(id)
);

#Verify the successful implementation of constraints by reviewing the table structure and constraints within the database.
EXPLAIN employees;
EXPLAIN attendance;

/*
 Task 3
 Extend the previous task of designing and implementing a MySQL database schema for a company management system
 with the addition of implementing indexes on specific columns to improve query performance
 and to optimize database efficiency. Identify columns that will be often used in search, join, or sorting operations,
 and consider implementing indexes on these columns to accelerate data retrieval.
 So, prioritize indexing columns that are commonly used and involved in operations that could benefit from index usage.
 */
-- index to search employees by last name
CREATE INDEX idx_lastname ON employees(last_name);

-- index to speed up search by department
CREATE INDEX idx_department ON employees(department_id);

-- index for projects searched by name
CREATE INDEX idx_projectname ON projects(name);

/*
 Task 4
 Create a MySQL database named "hospital".
 Establish a user account called "doctor" with the ability to connect from any host and set the password to "medic123".
 Grant the "doctor" user SELECT, INSERT, and DELETE permissions for all tables in the "hospital" database.
 Verify the "doctor" user's permissions to ensure the appropriate access is granted.
 Revoke the DELETE permission from the "doctor" user.
 Verify the updated permissions to confirm the changes.
 */
CREATE DATABASE hospital;
CREATE USER 'doctor'@'%' IDENTIFIED BY 'medic123';
GRANT SELECT, INSERT, DELETE ON hospital.* TO 'doctor'@'%';
SHOW GRANTS FOR 'doctor'@'%';
REVOKE DELETE ON hospital.* FROM 'doctor'@'%';
SHOW GRANTS FOR 'doctor'@'%';

/*
 Task 5
 Create a MySQL database named "bookstore".
 Design and implement at least five tables.
 Ensure constraints are in place, such as making sure book ISBNs are unique,
 sales dates are valid, and book prices are within a certain range.
 Verify the constraints by reviewing the table structure and ensuring data integrity.
 */
CREATE DATABASE bookstore;
USE bookstore;

CREATE TABLE authors (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  country VARCHAR(50)
);
CREATE TABLE books (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(100) NOT NULL,
  author_id INT UNSIGNED,
  price DECIMAL(6,2),
  publish_date DATE NOT NULL,
  CONSTRAINT chk_min_price CHECK (price >= 5),
  CONSTRAINT chk_max_price CHECK (price <= 200)
);
ALTER TABLE books
ADD FOREIGN KEY (author_id) REFERENCES authors(id);

CREATE TABLE customers (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE
);
CREATE TABLE sales (
  id INT PRIMARY KEY AUTO_INCREMENT,
  book_id INT UNSIGNED,
  customer_id INT UNSIGNED,
  sale_date DATE NOT NULL,
  quantity INT CHECK (quantity > 0),
  FOREIGN KEY (book_id) REFERENCES books(id),
  FOREIGN KEY (customer_id) REFERENCES customers(id)
);
CREATE TABLE categories (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) UNIQUE NOT NULL
);
ALTER TABLE books
ADD category_id INT UNSIGNED;
ALTER TABLE books
ADD FOREIGN KEY (category_id) REFERENCES books(id);

EXPLAIN books;
EXPLAIN sales;

/*
 Task 6
 Extend the previous task of designing and implementing a MySQL database schema
 for a bookstore management system with the addition of implementing indexes on specific columns
 to improve query performance and to optimize database efficiency.
 Identify columns that will be often used in search, join, or sorting operations,
 and consider implementing indexes on these columns to accelerate data retrieval.
 So, prioritize indexing columns that are commonly used and involved in operations that could benefit from index usage.
*/
-- Speed up search by book title
CREATE INDEX idx_book_title ON books(title);

-- Speed up searches by author
CREATE INDEX idx_author_name ON authors(name);

-- Speed up customer searches by email
CREATE INDEX idx_customer_email ON customers(email);

-- Speed up sales queries by date
CREATE INDEX idx_sale_date ON sales(sale_date);





