# Partitioning Optimization Report

## 1. Background

The `bookings` table was identified as a performance bottleneck due to its large size. Queries filtering by `start_date` were slow, requiring sequential scans across the entire dataset.

To optimize performance, the table was **partitioned by range on the `start_date` column**, with yearly partitions (`bookings_2023`, `bookings_2024`, `bookings_2025`, etc.).

---

## 2. Improvements Observed

### Before Partitioning

* Queries on date ranges scanned the entire `bookings` table.
* `EXPLAIN ANALYZE` showed **sequential scans** even when filtering by a narrow date range.
* Query time increased significantly as the table size grew.

### After Partitioning

* Queries with a date filter (`WHERE start_date BETWEEN ...`) scanned **only the relevant partition**.
* `EXPLAIN ANALYZE` confirmed **partition pruning** — irrelevant partitions were ignored.
* Execution time reduced from **hundreds of milliseconds** to **tens of milliseconds** (depending on dataset size).
* Additional **indexes on partitions** (e.g., `user_id`, `property_id`) further improved join and lookup performance.

---

## 3. Example Query Tested

```sql
EXPLAIN ANALYZE
SELECT booking_id, property_id, user_id, start_date, end_date, status
FROM bookings
WHERE start_date BETWEEN '2024-06-01' AND '2024-06-30';
```

### Execution Behavior

* **Before**: Sequential scan of full `bookings` table.
* **After**: Index/partition scan only on `bookings_2024`.

---

## 4. Conclusion

Partitioning the `bookings` table by `start_date` provided significant performance improvements:

* Reduced query execution time.
* Lower resource usage (CPU, I/O).
* Better scalability as data volume grows.