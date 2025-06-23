-- Start a transaction
START TRANSACTION;

-- Drop tables if they exist (in reverse order to avoid foreign key constraints issues)
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Menu;
DROP TABLE IF EXISTS Customers;

-- Create Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Menu table
CREATE TABLE Menu (
    menu_id INT PRIMARY KEY AUTO_INCREMENT,
    item_name VARCHAR(100) NOT NULL,
    category ENUM('Food', 'Beverage', 'Dessert') NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    is_available BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Orders table with foreign keys to Customers and Menu
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    menu_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    quantity INT NOT NULL DEFAULT 1,
    total_amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (menu_id) REFERENCES Menu(menu_id) ON DELETE RESTRICT
);

-- Insert sample data into Customers
INSERT INTO Customers (first_name, last_name, email, phone) VALUES
('Deepa', 'Ingole', 'sonaliforamit@gmail.com', '1213773128'),
('Mellisa', 'Hassen', 'Mellisa@email.com', '1231142312'),
('Josh', 'Brock', 'joshb@email.com', '4545323535');

-- Insert sample data into Menu
INSERT INTO Menu (item_name, category, price, is_available) VALUES
('Cheese Burger', 'Food', 8.99, TRUE),
('Coffee', 'Beverage', 4.50, TRUE),
('Apple Pie', 'Dessert', 6.25, TRUE),
('Pizza', 'Food', 7.99, TRUE);

-- Insert sample data into Orders
INSERT INTO Orders (customer_id, menu_id, quantity, total_amount) VALUES
(1, 1, 2, 17.98),  -- John Doe orders 2 Cheese Burgers
(2, 2, 1, 4.50),   -- Jane Smith orders 1 Cappuccino
(3, 3, 1, 6.25),   -- Mike Johnson orders 1 Chocolate Cake
(1, 4, 1, 7.99);   -- John Doe orders 1 Chicken Salad

-- Commit the transaction
COMMIT;