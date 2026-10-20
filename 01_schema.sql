CREATE DATABASE quickcommerce_analytics;
USE quickcommerce_analytics;

CREATE TABLE Areas (
    area_id INT PRIMARY KEY AUTO_INCREMENT,
    area_name VARCHAR(100) NOT NULL,
    zone VARCHAR(50),
    population_density VARCHAR(50),
    traffic_level VARCHAR(50)
);

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15),
    email VARCHAR(100),
    area_id INT,
    signup_date DATE,
    customer_type VARCHAR(50),
    preferred_payment VARCHAR(50),
    FOREIGN KEY (area_id) REFERENCES Areas(area_id)
);

CREATE TABLE Dark_Stores (
    store_id INT PRIMARY KEY AUTO_INCREMENT,
    store_code VARCHAR(20) UNIQUE NOT NULL,
    area_id INT,
    manager_name VARCHAR(100),
    capacity_per_hour INT,
    opening_date DATE,
    operating_status VARCHAR(50),
    FOREIGN KEY (area_id) REFERENCES Areas(area_id)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    brand VARCHAR(100),
    unit_price DECIMAL(10,2),
    stock_unit VARCHAR(50),
    shelf_life_days INT
);

CREATE TABLE Inventory (
    inventory_id INT PRIMARY KEY AUTO_INCREMENT,
    store_id INT,
    product_id INT,
    stock_available INT,
    reorder_level INT,
    last_restocked DATE,
    FOREIGN KEY (store_id) REFERENCES Dark_Stores(store_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    store_id INT,
    order_time DATETIME,
    order_value DECIMAL(10,2),
    payment_method VARCHAR(50),
    order_status VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (store_id) REFERENCES Dark_Stores(store_id)
);

CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    item_total DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE TABLE Delivery_Partners (
    partner_id INT PRIMARY KEY AUTO_INCREMENT,
    partner_name VARCHAR(100),
    phone VARCHAR(15),
    vehicle_type VARCHAR(50),
    joining_date DATE,
    assigned_area_id INT,
    partner_status VARCHAR(50),
    FOREIGN KEY (assigned_area_id) REFERENCES Areas(area_id)
);

CREATE TABLE Deliveries (
    delivery_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    partner_id INT,
    pickup_time DATETIME,
    delivered_time DATETIME,
    distance_km DECIMAL(5,2),
    delivery_status VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (partner_id) REFERENCES Delivery_Partners(partner_id)
);

CREATE TABLE Customer_Ratings (
    rating_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    customer_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    feedback TEXT,
    rating_time DATETIME,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Traffic_Conditions (
    traffic_id INT PRIMARY KEY AUTO_INCREMENT,
    area_id INT,
    recorded_time DATETIME,
    traffic_level VARCHAR(50),
    congestion_score INT,
    FOREIGN KEY (area_id) REFERENCES Areas(area_id)
);

CREATE TABLE Weather_Impact (
    weather_id INT PRIMARY KEY AUTO_INCREMENT,
    area_id INT,
    recorded_time DATETIME,
    weather_condition VARCHAR(50),
    impact_score INT,
    FOREIGN KEY (area_id) REFERENCES Areas(area_id)
);