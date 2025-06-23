# practice-DB Design

I have created a 3 tables to describe for myFoodCafe. menu, user , review 

The SQL script creates a database for myFoodCafe with three tables: Users, MenuItems, and Reviews, wrapped in a transaction.
The Users table stores reviewer information (full_name, email, photo) from reviews.json.
The MenuItems table holds menu data (item_name, description, price, category, image) from menu.json.
The Reviews table links users and menu items with comments and ratings (1-5), using foreign keys.
The script includes DROP TABLE statements to clear existing tables and INSERT statements to populate data