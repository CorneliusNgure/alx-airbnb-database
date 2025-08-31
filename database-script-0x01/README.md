# Airbnb Clone – Database Schema

  
The schema defines the relational structure, constraints, and indexes required for the application to run on **MySQL 8.0+**.  

---

## Contents
- `schema.sql` → SQL DDL script for creating all database tables, relationships, and indexes.

---

## Entities Overview
The schema models the following entities:

1. **Users** → Guests, Hosts, and Admins.  
2. **Properties** → Listings owned by hosts, including pricing and description.  
3. **Bookings** → Reservations made by users for properties.  
4. **Payments** → Records of transactions for bookings.  
5. **Reviews** → Guest feedback (rating + comments) for properties.  
6. **Messages** → Direct communication between users.  

---

## Setup Instructions

1. **Ensure MySQL 8.0+ is installed**
   ```bash
   mysql --version
   ```
2. **Create database (if not created)**
    ```sql
    CREATE DATABASE airbnb_clone;
    USE airbnb_clone;
    ```

3. **Run the script:**
    ```bash
    mysql -u your_username -p airbnb_clone < schema.sql
    ```

4. **Verify Tables**
    ```sql
    SHOW TABLES;
    ```
