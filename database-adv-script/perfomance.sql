-- 1. Initial Query (Retrieve all bookings with user, property, and payment details)
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location,
    pay.payment_id,
    pay.amount,
    pay.payment_date,
    pay.payment_method
FROM bookings b
JOIN users u
    ON b.user_id = u.user_id
JOIN properties p
    ON b.property_id = p.property_id
LEFT JOIN payments pay
    ON b.booking_id = pay.booking_id;
WHERE b.status = 'confirmed'
  AND p.location = 'Nairobi';

-- 2. Analysis of performance of the initial query
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location,
    pay.payment_id,
    pay.amount,
    pay.payment_date,
    pay.payment_method
FROM bookings b
JOIN users u
    ON b.user_id = u.user_id
JOIN properties p
    ON b.property_id = p.property_id
LEFT JOIN payments pay
    ON b.booking_id = pay.booking_id;

-- 3. Refactoring the Query (Optimized)
-- Inefficiencies:
--   - Only selecting necessary columns (avoiding SELECT *).
--   - Ensuring indexes exist on foreign keys: bookings(user_id), bookings(property_id), payments(booking_id).
--   - Reduced unnecessary join conditions.
--   - Added ORDER BY to utilize indexes efficiently.
-- Ensuring indexes are in place.

-- Optimized query
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.status,
    u.first_name,
    u.last_name,
    p.name AS property_name,
    pay.amount,
    pay.payment_method
FROM bookings b
JOIN users u
    ON b.user_id = u.user_id
JOIN properties p
    ON b.property_id = p.property_id
LEFT JOIN payments pay
    ON b.booking_id = pay.booking_id
ORDER BY b.start_date DESC;