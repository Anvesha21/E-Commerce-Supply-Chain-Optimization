INSERT INTO Areas (
    area_name,
    zone,
    population_density,
    traffic_level
)
VALUES
('Gandhipuram', 'Central', 'High', 'High'),
('RS Puram', 'West', 'Medium', 'Medium'),
('Peelamedu', 'East', 'High', 'High'),
('Saravanampatti', 'North', 'High', 'Medium'),
('Singanallur', 'South', 'Medium', 'High'),
('Vadavalli', 'West', 'Medium', 'Low'),
('Saibaba Colony', 'North-West', 'Medium', 'Medium'),
('Ganapathy', 'North-East', 'High', 'High'),
('Hope College', 'East', 'High', 'High'),
('Sundarapuram', 'South', 'Medium', 'Medium');

INSERT INTO Customers (
    customer_name,
    phone,
    email,
    area_id,
    signup_date,
    customer_type,
    preferred_payment
)
VALUES
('Arun Kumar', '9876543210', 'arun@gmail.com', 1, '2025-01-10', 'Premium', 'UPI'),
('Priya Sharma', '9876543211', 'priya@gmail.com', 3, '2025-02-15', 'Regular', 'COD'),
('Vignesh R', '9876543212', 'vignesh@gmail.com', 4, '2025-03-01', 'Premium', 'Card'),
('Sneha Iyer', '9876543213', 'sneha@gmail.com', 2, '2025-01-25', 'Regular', 'UPI'),
('Karthik M', '9876543214', 'karthik@gmail.com', 5, '2025-04-02', 'Premium', 'UPI'),
('Divya N', '9876543215', 'divya@gmail.com', 6, '2025-03-10', 'Regular', 'COD'),
('Rahul S', '9876543216', 'rahul@gmail.com', 7, '2025-02-20', 'Premium', 'Card'),
('Meena K', '9876543217', 'meena@gmail.com', 8, '2025-04-11', 'Regular', 'UPI'),
('Sanjay P', '9876543218', 'sanjay@gmail.com', 9, '2025-01-30', 'Premium', 'Card'),
('Anitha R', '9876543219', 'anitha@gmail.com', 10, '2025-03-25', 'Regular', 'COD');

INSERT INTO Dark_Stores (
    store_code,
    area_id,
    manager_name,
    capacity_per_hour,
    opening_date,
    operating_status
)
VALUES
('DS001', 1, 'Ramesh Kumar', 250, '2024-01-15', 'Active'),
('DS002', 2, 'Priya Menon', 180, '2024-02-10', 'Active'),
('DS003', 3, 'Suresh Babu', 300, '2024-03-05', 'Active'),
('DS004', 4, 'Anand Raj', 350, '2024-01-20', 'Active'),
('DS005', 5, 'Deepa Nair', 200, '2024-04-01', 'Active'),
('DS006', 6, 'Karthik Raman', 150, '2024-02-25', 'Maintenance');

INSERT INTO Products (
    product_name,
    category,
    brand,
    unit_price,
    stock_unit,
    shelf_life_days
)
VALUES
('Aavin Milk 1L', 'Dairy', 'Aavin', 52.00, 'Packet', 2),
('Bread', 'Bakery', 'Modern', 40.00, 'Packet', 5),
('Eggs 12 Pack', 'Dairy', 'Farm Fresh', 78.00, 'Tray', 10),
('Tomato', 'Vegetables', 'Local Farm', 30.00, 'Kg', 4),
('Potato', 'Vegetables', 'Local Farm', 45.00, 'Kg', 10),
('Coca Cola 750ml', 'Beverages', 'Coca Cola', 40.00, 'Bottle', 180),
('Lays Chips', 'Snacks', 'Lays', 20.00, 'Packet', 120),
('Good Day Biscuits', 'Snacks', 'Britannia', 35.00, 'Packet', 90),
('Surf Excel 1kg', 'Household', 'Surf Excel', 210.00, 'Packet', 365),
('Toor Dal 1kg', 'Groceries', 'Aashirvaad', 160.00, 'Packet', 180);

INSERT INTO Inventory (
    store_id,
    product_id,
    stock_available,
    reorder_level,
    last_restocked
)
VALUES
(1,1,120,40,'2026-05-25'),
(1,2,80,30,'2026-05-25'),
(1,3,60,20,'2026-05-25'),
(2,1,50,40,'2026-05-24'),
(2,4,100,35,'2026-05-24'),
(2,7,150,50,'2026-05-24'),
(3,1,200,60,'2026-05-26'),
(3,5,90,30,'2026-05-26'),
(3,8,110,40,'2026-05-26'),
(4,2,70,25,'2026-05-26'),
(4,6,130,50,'2026-05-26'),
(4,9,40,20,'2026-05-26'),
(5,3,55,20,'2026-05-23'),
(5,10,95,30,'2026-05-23'),
(6,1,20,40,'2026-05-22'),
(6,7,45,25,'2026-05-22');

INSERT INTO Orders (
    customer_id,
    store_id,
    order_time,
    order_value,
    payment_method,
    order_status
)
VALUES
(1,1,'2026-05-28 08:15:00',420.50,'UPI','Delivered'),
(2,3,'2026-05-28 09:10:00',180.00,'COD','Delivered'),
(3,4,'2026-05-28 10:05:00',560.75,'Card','Delivered'),
(4,2,'2026-05-28 11:20:00',240.00,'UPI','Cancelled'),
(5,5,'2026-05-28 12:45:00',780.20,'UPI','Delivered'),
(6,6,'2026-05-28 13:15:00',150.00,'COD','Pending'),
(7,1,'2026-05-28 14:05:00',320.40,'Card','Delivered'),
(8,3,'2026-05-28 15:30:00',210.00,'UPI','Delivered'),
(9,4,'2026-05-28 17:00:00',890.90,'Card','Delivered'),
(10,2,'2026-05-28 19:10:00',130.50,'COD','Cancelled');

INSERT INTO Order_Items (
    order_id,
    product_id,
    quantity,
    item_total
)
VALUES
(1, 1, 2, 104.00),
(1, 2, 1, 40.00),
(1, 3, 1, 78.00),

(2, 4, 2, 60.00),
(2, 7, 3, 60.00),

(3, 9, 2, 420.00),
(3, 10, 1, 160.00),

(4, 6, 2, 80.00),
(4, 7, 2, 40.00),

(5, 1, 4, 208.00),
(5, 5, 3, 135.00),
(5, 8, 2, 70.00),

(6, 2, 2, 80.00),

(7, 3, 2, 156.00),
(7, 6, 2, 80.00),

(8, 4, 3, 90.00),
(8, 8, 2, 70.00),

(9, 9, 3, 630.00),

(10, 7, 2, 40.00);

INSERT INTO Delivery_Partners (
    partner_name,
    phone,
    vehicle_type,
    joining_date,
    assigned_area_id,
    partner_status
)
VALUES
('Naveen Kumar', '9000000001', 'Bike', '2025-01-10', 1, 'Active'),

('Aravind Raj', '9000000002', 'Scooter', '2025-02-15', 3, 'Active'),

('Prakash M', '9000000003', 'Bike', '2025-03-01', 4, 'Active'),

('Sathish K', '9000000004', 'Bike', '2025-01-20', 2, 'Active'),

('Dinesh B', '9000000005', 'Scooter', '2025-04-05', 5, 'Active'),

('Lokesh V', '9000000006', 'Bike', '2025-03-12', 6, 'Inactive'),

('Manoj S', '9000000007', 'Bike', '2025-02-18', 1, 'Active'),

('Hari Prasad', '9000000008', 'Scooter', '2025-04-10', 3, 'Active');

INSERT INTO Deliveries (
    order_id,
    partner_id,
    pickup_time,
    delivered_time,
    distance_km,
    delivery_status
)
VALUES
(1, 1, '2026-05-28 08:20:00', '2026-05-28 08:38:00', 3.5, 'Delivered'),

(2, 2, '2026-05-28 09:15:00', '2026-05-28 09:40:00', 4.2, 'Delivered'),

(3, 3, '2026-05-28 10:10:00', '2026-05-28 10:42:00', 5.8, 'Delayed'),

(5, 5, '2026-05-28 12:50:00', '2026-05-28 13:12:00', 3.9, 'Delivered'),

(7, 7, '2026-05-28 14:10:00', '2026-05-28 14:45:00', 6.1, 'Delayed'),

(8, 8, '2026-05-28 15:35:00', '2026-05-28 15:55:00', 2.7, 'Delivered'),

(9, 3, '2026-05-28 17:05:00', '2026-05-28 17:50:00', 7.3, 'Delayed');

INSERT INTO Customer_Ratings (
    order_id,
    customer_id,
    rating,
    feedback,
    rating_time
)
VALUES
(1, 1, 5, 'Very fast delivery', '2026-05-28 09:00:00'),

(2, 2, 4, 'Good packaging', '2026-05-28 10:00:00'),

(3, 3, 2, 'Delivery was late', '2026-05-28 11:00:00'),

(5, 5, 5, 'Excellent service', '2026-05-28 13:30:00'),

(7, 7, 3, 'Average experience', '2026-05-28 15:00:00'),

(8, 8, 4, 'Quick delivery', '2026-05-28 16:10:00'),

(9, 9, 1, 'Order arrived very late', '2026-05-28 18:10:00');

INSERT INTO Traffic_Conditions (
    area_id,
    recorded_time,
    traffic_level,
    congestion_score
)
VALUES
(1, '2026-05-28 08:00:00', 'High', 85),

(2, '2026-05-28 09:00:00', 'Medium', 60),

(3, '2026-05-28 10:00:00', 'High', 90),

(4, '2026-05-28 11:00:00', 'Medium', 55),

(5, '2026-05-28 12:00:00', 'High', 88),

(6, '2026-05-28 13:00:00', 'Low', 30),

(1, '2026-05-28 18:00:00', 'Very High', 95),

(3, '2026-05-28 19:00:00', 'Very High', 98);

INSERT INTO Weather_Impact (
    area_id,
    recorded_time,
    weather_condition,
    impact_score
)
VALUES
(1, '2026-05-28 08:00:00', 'Sunny', 10),

(2, '2026-05-28 09:00:00', 'Cloudy', 20),

(3, '2026-05-28 10:00:00', 'Rainy', 75),

(4, '2026-05-28 11:00:00', 'Sunny', 15),

(5, '2026-05-28 12:00:00', 'Rainy', 80),

(6, '2026-05-28 13:00:00', 'Cloudy', 25),

(1, '2026-05-28 18:00:00', 'Heavy Rain', 95),

(3, '2026-05-28 19:00:00', 'Heavy Rain', 98);