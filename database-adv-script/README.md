# SQL Join Queries 

Examples of how to use different types of SQL joins (INNER JOIN, LEFT JOIN, FULL OUTER JOIN) on the **Airbnb clone database schema**.

---

## 🔹 1. INNER JOIN

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

Only returns bookings that are linked to existing users.

---

## 🔹 2. LEFT JOIN

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
    ON p.property_id = r.property_id;
ORDER BY p.name;
```

Returns all properties. If a property has no reviews, review-related columns will appear as `NULL`.
Results are ordered alphabetically by property name.

---

## 🔹 3. FULL OUTER JOIN

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

Returns all users and all bookings:

* Users without bookings will show `NULL` in booking columns.
* Bookings without valid users will show `NULL` in user columns.

---

## Notes

* **INNER JOIN** → only matching rows.
* **LEFT JOIN** → all from the left table + matches from the right.
* **FULL OUTER JOIN** → all rows from both tables, matched where possible.