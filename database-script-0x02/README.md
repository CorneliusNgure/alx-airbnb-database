# SQL Join and Subquery Examples

This README provides SQL queries demonstrating the use of different types of joins and subqueries in a PostgreSQL Airbnb-like database schema.

---

## 1. INNER JOIN

**Retrieve all bookings and the respective users who made those bookings.**

```sql
SELECT 
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM bookings b
INNER JOIN users u
    ON b.user_id = u.user_id;
```

---

## 2. LEFT JOIN

**Retrieve all properties and their reviews, including properties that have no reviews.**

```sql
SELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    r.review_id,
    r.rating,
    r.comment,
    r.created_at AS review_date
FROM properties p
LEFT JOIN reviews r
    ON p.property_id = r.property_id
ORDER BY p.name;
```

---

## 3. FULL OUTER JOIN

**Retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.**

```sql
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status
FROM users u
FULL OUTER JOIN bookings b
    ON u.user_id = b.user_id;
```

---

## 4. Subquery => Average Rating > 4.0

**Find all properties where the average rating is greater than 4.0 using a subquery.**

```sql
SELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    p.pricepernight
FROM properties p
WHERE p.property_id IN (
    SELECT r.property_id
    FROM reviews r
    GROUP BY r.property_id
    HAVING AVG(r.rating) > 4.0
);
```

---

## 5. JOIN + GROUP BY Alternative

**Find all properties with average rating greater than 4.0 using a JOIN.**

```sql
SELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    p.pricepernight,
    AVG(r.rating) AS avg_rating
FROM properties p
INNER JOIN reviews r
    ON p.property_id = r.property_id
GROUP BY p.property_id, p.name, p.location, p.pricepernight
HAVING AVG(r.rating) > 4.0;
```

---

## 6. Correlated Subquery — Users with More Than 3 Bookings

**Find users who have made more than 3 bookings using a correlated subquery.**

```sql
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM users u
WHERE (
    SELECT COUNT(*)
    FROM bookings b
    WHERE b.user_id = u.user_id
) > 3;
```

---

## 7. JOIN + GROUP BY Alternative for User Bookings

**Find users who have made more than 3 bookings using a JOIN with GROUP BY.**

```sql
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    COUNT(b.booking_id) AS total_bookings
FROM users u
INNER JOIN bookings b
    ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name, u.email
HAVING COUNT(b.booking_id) > 3;
```