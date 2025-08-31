# Airbnb Clone – Seed Data

This is the data used to populate the Airbnb Clone database with sample data for development and testing.  

---

## 📌 Contents
- **`seed.sql`** → Inserts sample data into all core tables:
  - **users** (guests, hosts, admin)  
  - **properties** (apartments, villas, cottages)  
  - **bookings** (confirmed & pending)  
  - **payments** (credit card, etc.)  
  - **reviews** (ratings and comments)  
  - **messages** (conversations between users)  

---

## 🚀 Usage

1. ** Make sure the database schema is already created by running:**
```bash
   mysql -u your_user -p < ../schema/schema.sql
```

2. **Load the seed data**
```bash
mysql -u your_user -p < seed.sql
```

3. **Veriy the data**
```sql
USE airbnb_clone;
SELECT * FROM users;
SELECT * FROM properties;
SELECT * FROM bookings;
```
