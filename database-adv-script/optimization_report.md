# Query Optimization Report

## 1. Initial Query

The original query retrieved **all bookings along with user details, property details, and payment details**:

```sql
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
```

### Issues Identified

* Selected **all columns** from multiple tables, even when not all were needed.
* Execution plan showed **sequential scans** on `bookings`, `users`, `properties`, and `payments`.
* Missing or unused indexes led to **higher execution time** when joining large tables.

---

## 2. Performance Analysis (Using `EXPLAIN ANALYZE`)

### Key Observations

* **Seq Scan** on `bookings` and `payments`.
* **Hash Join** between `bookings` and `users` due to lack of indexed join column usage.
* Increasing dataset size significantly increases query cost.

---

## 3. Refactored Query

Optimized by:

1. Selecting **only necessary columns**.
2. Ensuring **indexes** exist on high-usage foreign keys:

   ```sql
   CREATE INDEX IF NOT EXISTS idx_bookings_user_id ON bookings(user_id);
   CREATE INDEX IF NOT EXISTS idx_bookings_property_id ON bookings(property_id);
   CREATE INDEX IF NOT EXISTS idx_payments_booking_id ON payments(booking_id);
   ```

3. Adding **ORDER BY b.start\_date DESC** to benefit from index usage.

### Optimized Query

```sql
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
```

---

## 4. Results After Optimization

### Execution Plan Improvements

* **Index Scan** used instead of sequential scans.
* **Nested Loop / Merge Join** instead of Hash Join in some cases.
* Reduced number of rows processed at each step.

### Execution Time

* Before and after optimization times were varied significantly.

*(Note: actual times depend on dataset size and system performance, but relative improvement is consistent.)*

---

## 5. Conclusion

* Always create indexes on **foreign key columns** (`user_id`, `property_id`, `booking_id`).
* Avoid `SELECT *`; only fetch required columns.
* Use `EXPLAIN ANALYZE` regularly to identify slow queries.
* Monitor queries as data grows; indexes may need to be re-evaluated for effectiveness.

---