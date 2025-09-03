# Database Indexing

How to identify high-usage columns in the **Users**, **Bookings**, and **Properties** tables, create indexes on those columns, and measure query performance before and after indexing.

---

## 1. Identifying High-Usage Columns

Indexes should be created on columns frequently used in **WHERE**, **JOIN**, or **ORDER BY** clauses.

* **Users Table**

  * `user_id` → Used in JOINs with Bookings.
  * `email` → Often used in login/authentication queries (WHERE clause).

* **Bookings Table**

  * `booking_id` → Primary key.
  * `user_id` → Foreign key, used in JOINs with Users.
  * `property_id` → Foreign key, used in JOINs with Properties.
  * `start_date`, `end_date` → Common in search queries (WHERE clause).

* **Properties Table**

  * `property_id` → Primary key.
  * `host_id` → Foreign key, used in JOINs with Users.
  * `location`, `pricepernight` → Used in filtering queries (WHERE/ORDER BY).

---

## 2. SQL Index Commands (database\_index.sql)

```sql
-- =============================
-- User Table Indexes
-- =============================
CREATE INDEX idx_users_email ON users(email);

-- =============================
-- Bookings Table Indexes
-- =============================
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_dates ON bookings(start_date, end_date);

-- =============================
-- Properties Table Indexes
-- =============================
CREATE INDEX idx_properties_host_id ON properties(host_id);
CREATE INDEX idx_properties_location ON properties(location);
CREATE INDEX idx_properties_price ON properties(pricepernight);
```

---

## 3. Measuring Performance with EXPLAIN/ANALYZE

`EXPLAIN` or `EXPLAIN ANALYZE` to measure performance **before and after adding indexes**.

### Without Index

```sql
EXPLAIN ANALYZE
SELECT *
FROM bookings
WHERE user_id = 'some-user-uuid';
```

### With Index
```sql
EXPLAIN ANALYZE
SELECT *
FROM bookings
WHERE user_id = 'some-user-uuid';
```
---

## 4. Key Notes

* Always index **foreign keys**.
* Index **frequently queried columns**.
* Avoid over-indexing (slows down INSERT/UPDATE/DELETE).
* Use `EXPLAIN ANALYZE` to verify index usage.

---
