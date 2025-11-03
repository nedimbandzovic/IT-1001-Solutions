#Task 1
#Design and create a database to manage student enrollment information for a university. The database should include tables for students, courses, enrollment records,
#and any additional information deemed necessary.
#Use DDL commands to create the necessary tables with appropriate data types, constraints, and relationships. 

CREATE DATABASE `university_db`;
USE `university_db`;

CREATE TABLE departments (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(100) NOT NULL
) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE,
    Email VARCHAR(100) UNIQUE NOT NULL,
    EnrollmentDate DATE NOT NULL
) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE courses (
    CourseID INT PRIMARY KEY AUTO_INCREMENT,
    CourseName VARCHAR(100) NOT NULL,
    DepartmentID INT,
    Credits INT,
    FOREIGN KEY (DepartmentID) REFERENCES departments(DepartmentID)
) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE enrollments (
    EnrollmentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATE NOT NULL,
    Grade CHAR(2),
    FOREIGN KEY (StudentID) REFERENCES students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES courses(CourseID),
    UNIQUE (StudentID, CourseID) 
) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

#Task 2
#Extend the existing Student Enrollment Database created in Task 1 to include support for managing an online bookstore. The bookstore database should include tables for books, customers, 
#, and payments, as well as integration with student enrollment data for special discounts and promotions. 

USE `university_db`;

CREATE TABLE books (
    BookID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(100) NOT NULL,
    ISBN VARCHAR(20) UNIQUE NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    StudentDiscountRate DECIMAL(3, 2) DEFAULT 0.10  
) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT,  -- This links customers to students if they are students
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    FOREIGN KEY (StudentID) REFERENCES students(StudentID)
) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    OrderDate DATETIME NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES customers(CustomerID)
) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE payments (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    PaymentDate DATETIME NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    PaymentMethod VARCHAR(50) NOT NULL, 
    FOREIGN KEY (OrderID) REFERENCES orders(OrderID)
) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

#Task 3
#Design and create a database to manage events for a university or organization. The database should include tables for events, attendees, 
#event registrations, and any additional information deemed necessary. Use DDL commands to create the necessary tables with appropriate data types, constraints, and relationships.

CREATE DATABASE `event_management_db`;
USE `event_management_db`;

CREATE TABLE events (
    EventID INT PRIMARY KEY AUTO_INCREMENT,
    EventName VARCHAR(255) NOT NULL,
    EventDate DATETIME NOT NULL,
    Location VARCHAR(255) NOT NULL,
    Description TEXT,
    Capacity INT,  
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE attendees (
    AttendeeID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    RegistrationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE event_registrations (
    RegistrationID INT PRIMARY KEY AUTO_INCREMENT,
    EventID INT,
    AttendeeID INT,
    RegistrationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (EventID) REFERENCES events(EventID),
    FOREIGN KEY (AttendeeID) REFERENCES attendees(AttendeeID),
    UNIQUE (EventID, AttendeeID) 
) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

#Task 4
#Develop a database to manage the catalog of books, library members, book loans, and returns. 
#The database should include tables for books, authors, members, loans, and returns. 
#Use DDL commands to create the necessary tables with appropriate data types, constraints, and relationships.

CREATE DATABASE `library_management_db`;
USE `library_management_db`;

CREATE TABLE authors (
    AuthorID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Biography TEXT
) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE books (
    BookID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(255) NOT NULL,
    AuthorID INT,
    ISBN VARCHAR(20) UNIQUE NOT NULL,
    PublishedYear YEAR,
    CopiesAvailable INT DEFAULT 1,
    FOREIGN KEY (AuthorID) REFERENCES authors(AuthorID)
) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE members (
    MemberID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    MembershipDate DATE NOT NULL
) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE loans (
    LoanID INT PRIMARY KEY AUTO_INCREMENT,
    BookID INT,
    MemberID INT,
    LoanDate DATE NOT NULL,
    DueDate DATE NOT NULL,
    FOREIGN KEY (BookID) REFERENCES books(BookID),
    FOREIGN KEY (MemberID) REFERENCES members(MemberID)
) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE returns (
    ReturnID INT PRIMARY KEY AUTO_INCREMENT,
    LoanID INT,
    ReturnDate DATE NOT NULL,
    FOREIGN KEY (LoanID) REFERENCES loans(LoanID)
) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

#Task 5
#Create a database to manage hotel room reservations, guest information, room availability, and billing.
#The database should include tables for guests, rooms, reservations, and payments.
#Use DDL commands to create the necessary tables with appropriate data types, constraints, and relationships.

CREATE DATABASE hotel_management;
USE hotel_management;

CREATE TABLE guests (
    guest_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(15)
);
CREATE TABLE rooms (
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    room_number VARCHAR(10) NOT NULL,
    room_type VARCHAR(50) NOT NULL,
    capacity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);
CREATE TABLE reservations (
    reservation_id INT PRIMARY KEY AUTO_INCREMENT,
    guest_id INT,
    room_id INT,
    check_in DATE NOT NULL,
    check_out DATE NOT NULL
);
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    reservation_id INT,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date DATETIME NOT NULL
);

#Task 6
#Develop a database to manage inventory, product details, sales transactions, and supplier information.
#The database should include tables for products, categories, suppliers, sales, and inventory.
#Use DDL commands to create the necessary tables with appropriate data types, constraints, and relationships.

CREATE DATABASE inventory_management;
USE inventory_management;

CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL
);
CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_name VARCHAR(50) NOT NULL,
    contact_info VARCHAR(100)
);
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(50) NOT NULL,
    category_id INT,
    supplier_id INT,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(category_id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);
CREATE TABLE sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    quantity_sold INT NOT NULL,
    sale_date DATETIME NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
CREATE TABLE inventory (
    inventory_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    quantity INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
#Task 7
#Create a database to handle menu items, table reservations, customer orders, and staff scheduling.
#The database should include tables for menu items, orders, reservations, tables, and staff.
#Use DDL commands to create the necessary tables with appropriate data types, constraints, and relationships.
CREATE DATABASE restaurant_management;
USE restaurant_management;
CREATE TABLE menu_items (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    item_name VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    description VARCHAR(255)
);
CREATE TABLE tables (
    table_id INT PRIMARY KEY AUTO_INCREMENT,
    table_number VARCHAR(10) NOT NULL,
    capacity INT NOT NULL
);
CREATE TABLE staff (
    staff_id INT PRIMARY KEY AUTO_INCREMENT,
    staff_name VARCHAR(50) NOT NULL,
    position VARCHAR(50) NOT NULL,
    schedule DATETIME
);
CREATE TABLE reservations (
    reservation_id INT PRIMARY KEY AUTO_INCREMENT,
    table_id INT,
    customer_name VARCHAR(50) NOT NULL,
    reservation_date DATETIME NOT NULL,
    FOREIGN KEY (table_id) REFERENCES tables(table_id)
);
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    reservation_id INT,
    item_id INT,
    quantity INT NOT NULL,
    order_date DATETIME NOT NULL,
    FOREIGN KEY (reservation_id) REFERENCES reservations(reservation_id),
    FOREIGN KEY (item_id) REFERENCES menu_items(item_id)
);
#Task 8
#Develop a database to manage music tracks, artists, playlists, and user subscriptions. The database should include tables for tracks, artists, albums, playlists, and user accounts.
#Use DDL commands to create the necessary tables with appropriate data types, constraints, and relationships.
CREATE DATABASE music_management;
USE music_management;
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE
);
CREATE TABLE tracks (
    track_id INT PRIMARY KEY AUTO_INCREMENT,
    track_name VARCHAR(50) NOT NULL,
    artist_name VARCHAR(50) NOT NULL,
    album_name VARCHAR(50),
    duration TIME NOT NULL,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
