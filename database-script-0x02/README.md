# Airbnb Clone – Seed Data

This directory contains the `seed.sql` file used to populate the **Airbnb Clone** database with sample data.  
It should be run **after** creating the schema (`schema.sql`).

---

## Contents
- **`seed.sql`** – Inserts sample data for:
  - Users
  - Properties
  - Bookings
  - Payments
  - Reviews
  - Messages

---

## How to Run

### 1. Make sure you have created the database and schema:

   ```bash
   psql -U your_username -d airbnb_clone -f ../schema/schema.sql
```

### 2. Run the script to insert sample data:
```bash
psql -U your_username -d airbnb_clone -f seed.sql
```

### 3. Verify Data:
```sql
SELECT * FROM users;
SELECT * FROM properties;
SELECT * FROM bookings;
```
