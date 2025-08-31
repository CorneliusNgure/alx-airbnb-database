# 🗄️ Airbnb Clone – Database Schema (PostgreSQL)

This directory contains the **`schema.sql`** file, which defines the PostgreSQL database schema for the Airbnb Clone project.  

---

## Contents
- **`schema.sql`** → Creates tables, primary keys, foreign keys, indexes, and constraints for:
  - `users` – Authentication & profiles  
  - `properties` – Listings hosted by users  
  - `bookings` – Reservations with historical pricing  
  - `payments` – Transactions tied to bookings  
  - `reviews` – Ratings & comments for properties  
  - `messages` – Direct communication between users  

---

## Usage

### 1. Create the database
```bash
createdb airbnb_clone
```

### 2. Load the schema:
```bash
psql -d airbnb_clone -f schema.sql
```

### 3. Verify Tables:
```sql
\c airbnb_clone
\dt;
```


