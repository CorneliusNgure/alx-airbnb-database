-- ============================================
-- Airbnb Clone – Seed Data (PostgreSQL)
-- ============================================
-- Run this AFTER schema.sql to populate tables
-- ============================================

-- =========================
-- Users
-- =========================
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)
VALUES
  (uuid_generate_v4(), 'Alice', 'Johnson', 'alice@example.com', 'hashed_password_1', '+254700111111', 'guest', NOW()),
  (uuid_generate_v4(), 'Bob', 'Kamau', 'bob@example.com', 'hashed_password_2', '+254700222222', 'host', NOW()),
  (uuid_generate_v4(), 'Catherine', 'Otieno', 'catherine@example.com', 'hashed_password_3', '+254700333333', 'host', NOW()),
  (uuid_generate_v4(), 'David', 'Smith', 'david@example.com', 'hashed_password_4', '+254700444444', 'guest', NOW()),
  (uuid_generate_v4(), 'Eunice', 'Muriuki', 'eunice@example.com', 'hashed_password_5', '+254700555555', 'admin', NOW());

-- =========================
-- Properties
-- =========================
INSERT INTO properties (property_id, host_id, name, description, location, pricepernight, created_at, updated_at)
VALUES
  (uuid_generate_v4(), (SELECT user_id FROM users WHERE email='bob@example.com'),
   'Cozy Apartment Nairobi', '2-bedroom furnished apartment in Westlands', 'Nairobi, Kenya', 50.00, NOW(), NOW()),
  (uuid_generate_v4(), (SELECT user_id FROM users WHERE email='catherine@example.com'),
   'Beachfront Cottage Mombasa', 'Private beach house with ocean view', 'Mombasa, Kenya', 120.00, NOW(), NOW()),
  (uuid_generate_v4(), (SELECT user_id FROM users WHERE email='catherine@example.com'),
   'Kisumu Lakeview Villa', 'Modern villa overlooking Lake Victoria', 'Kisumu, Kenya', 90.00, NOW(), NOW());

-- =========================
-- Bookings
-- =========================
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at)
VALUES
  (uuid_generate_v4(),
   (SELECT property_id FROM properties WHERE name='Cozy Apartment Nairobi'),
   (SELECT user_id FROM users WHERE email='alice@example.com'),
   '2025-09-15', '2025-09-20', 250.00, 'confirmed', NOW()),
  (uuid_generate_v4(),
   (SELECT property_id FROM properties WHERE name='Beachfront Cottage Mombasa'),
   (SELECT user_id FROM users WHERE email='david@example.com'),
   '2025-12-01', '2025-12-05', 480.00, 'pending', NOW());

-- =========================
-- Payments
-- =========================
INSERT INTO payments (payment_id, booking_id, amount, payment_date, payment_method)
VALUES
  (uuid_generate_v4(),
   (SELECT booking_id FROM bookings WHERE status='confirmed' LIMIT 1),
   250.00, NOW(), 'credit_card');

-- =========================
-- Reviews
-- =========================
INSERT INTO reviews (review_id, property_id, user_id, rating, comment, created_at)
VALUES
  (uuid_generate_v4(),
   (SELECT property_id FROM properties WHERE name='Cozy Apartment Nairobi'),
   (SELECT user_id FROM users WHERE email='alice@example.com'),
   5, 'Wonderful stay! The host was very helpful.', NOW()),
  (uuid_generate_v4(),
   (SELECT property_id FROM properties WHERE name='Beachfront Cottage Mombasa'),
   (SELECT user_id FROM users WHERE email='david@example.com'),
   4, 'Amazing views but could improve WiFi speed.', NOW());

-- =========================
-- Messages
-- =========================
INSERT INTO messages (message_id, sender_id, recipient_id, message_body, sent_at)
VALUES
  (uuid_generate_v4(),
   (SELECT user_id FROM users WHERE email='alice@example.com'),
   (SELECT user_id FROM users WHERE email='bob@example.com'),
   'Hi Bob, is the apartment available for early check-in?', NOW()),
  (uuid_generate_v4(),
   (SELECT user_id FROM users WHERE email='bob@example.com'),
   (SELECT user_id FROM users WHERE email='alice@example.com'),
   'Yes Alice, you can check in from 10am.', NOW());

