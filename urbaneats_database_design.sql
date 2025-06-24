-- Start a transaction
START TRANSACTION;

-- Drop tables if they exist (in reverse order to avoid foreign key constraints issues)
DROP TABLE IF EXISTS Purchases;
DROP TABLE IF EXISTS Dishes;
DROP TABLE IF EXISTS Branches;

-- Create Branches table
CREATE TABLE Branches (
    branch_id INT PRIMARY KEY AUTO_INCREMENT,
    branch_title VARCHAR(100) NOT NULL,
    street_address VARCHAR(255) NOT NULL,
    city_name VARCHAR(50) NOT NULL,
    contact_phone VARCHAR(20),
    registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Dishes table
CREATE TABLE Dishes (
    dish_id INT PRIMARY KEY AUTO_INCREMENT,
    branch_id INT NOT NULL,
    dish_title VARCHAR(100) NOT NULL,
    details TEXT NOT NULL,
    cost DECIMAL(10,2) NOT NULL,
    dish_type ENUM('burgers', 'pizzas', 'pastas', 'salads', 'sides', 'drinks') NOT NULL,
    available BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id) 
);

-- Create Purchases table with foreign keys to Branches and Dishes
CREATE TABLE Purchases (
    purchase_id INT PRIMARY KEY AUTO_INCREMENT,
    branch_id INT NOT NULL,
    dish_id INT NOT NULL,
    client_email VARCHAR(100) NOT NULL,
    purchase_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    count INT NOT NULL DEFAULT 1,
    total_price DECIMAL(10,2) NOT NULL,
    reward_points INT DEFAULT 0,
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id) ,
    FOREIGN KEY (dish_id) REFERENCES Dishes(dish_id) 
);

-- Insert sample data into Branches
INSERT INTO Branches (branch_title, street_address, city_name, contact_phone) VALUES
('Urban Eats Central', '321 King St', 'Chicago', '555-0401'),
('Urban Eats Uptown', '654 Elm Ave', 'Chicago', '555-0402'),
('Urban Eats Riverwalk', '987 Maple Rd', 'Chicago', '555-0403');

-- Insert sample data into Dishes (adapted from menu.json)
INSERT INTO Dishes (branch_id, dish_title, details, cost, dish_type) VALUES
(1, 'Burger', 'Delicious beef burger with cheese and fries.', 9.99, 'burgers'),
(1, 'Pizza', 'Classic Margherita pizza.', 12.99, 'pizzas'),
(2, 'Pasta', 'Spaghetti with tomato sauce.', 10.99, 'pastas'),
(2, 'Salad', 'Fresh garden salad.', 7.99, 'salads'),
(3, 'Chicken Wings', 'Spicy chicken wings.', 11.99, 'sides'),
(3, 'Coffee', 'Energetic espresso.', 1.99, 'drinks');

-- Insert sample data into Purchases (adapted from reviews.json for client emails)
INSERT INTO Purchases (branch_id, dish_id, client_email, count, total_price, reward_points) VALUES
(1, 1, 'melissa.h@email.com', 2, 19.98, 20),  -- Melissa H. buys 2 Burgers at Central
(1, 2, 'josh.b@email.com', 1, 12.99, 13),    -- Josh B. buys 1 Pizza at Central
(2, 3, 'sean.a@email.com', 1, 10.99, 11),    -- Sean A. buys 1 Pasta at Uptown
(2, 4, 'shelvy.b@email.com', 1, 7.99, 8),    -- Shelvy B. buys 1 Salad at Uptown
(3, 5, 'carrie.jones@email.com', 3, 35.97, 36), -- Carrie Jones buys 3 Chicken Wings at Riverwalk
(3, 6, 'darren.h@email.com', 2, 3.98, 4);    -- Darren H. buys 2 Coffees at Riverwalk

-- Commit the transaction
COMMIT;