# 📑 Database Normalization – Airbnb Schema

## 1. Introduction
The purpose of database normalization is to reduce redundancy and improve data integrity.  
Will apply **1NF → 2NF → 3NF** principles to the schema (User, Property, Booking, Payment, Review, and Message).  

In practice, however, some intentional denormalization may be kept for business reasons.  
A key example is the `total_price` field in the `BOOKING` table, which we will examine closely.  

---

## 2. First Normal Form (1NF) – Eliminate Repeating Groups
**Rule:** Each column should contain atomic values, and each record must be unique.  
  
- No violation here:
    - All attributes are atomic (`first_name`, `last_name`, `email`, etc.).  
    - No multi-valued fields (e.g., `role` is a single ENUM, not a list).  
    - Each table has a **primary key** ensuring uniqueness.  

---

## 3. Second Normal Form (2NF) – Eliminate Partial Dependencies
**Rule:** Non-key attributes must depend on the **whole primary key**, not just part of it.  
- Only applies to composite primary keys, which we don’t have. All tables use surrogate UUIDs as PKs.  

- No violation here either. 
    - Each non-key attribute depends entirely on its table’s UUID primary key.  
    - Example: In `BOOKING`, `start_date`, `end_date`, and `status` depend only on `booking_id`.  

---

## 4. Third Normal Form (3NF) – Eliminate Transitive Dependencies
**Rule:** Non-key attributes should not depend on other non-key attributes.  

### Checks per table:
- **USER**  
  - `role` is not derived from another field  
  - `email` is unique, no duplication risk  

- **PROPERTY**  
  - `pricepernight` depends only on the property itself, not `location` or `host_id`  
  - No derived fields like `total_value`

- **BOOKING**  
  - ⚠️ **`total_price` is not fundamental data.**  
    - It is **derived from other attributes**:  
      - `PROPERTY.pricepernight`  
      - `BOOKING.start_date` and `BOOKING.end_date`  
    - Strictly speaking, this is a **violation of 3NF**, since `total_price` has a **transitive dependency** and could always be recomputed.  
  - **Why keep it anyway:**  
    - In industry practice, `total_price` is stored as the **contractual amount** agreed upon at booking time.  
    - This ensures historical accuracy: if `pricepernight` changes later, old bookings still reflect the correct amount.  
    - Thus, while technically denormalized, it serves a **business-critical purpose**.  

- **PAYMENT**  
  - `amount` depends directly on the booking.  
  - Possible redundancy if `amount` = `total_price`, but payments can be partial.  

- **REVIEW**  
  - `rating` and `comment` depend directly on the review.  

- **MESSAGE**  
  - `sender_id` and `recipient_id` both reference `USER`,  

---

## 5. Final Adjustments for 3NF
- **Keep `BOOKING.total_price`**, with the understanding that:  
  - It is **derived, not fundamental**.  
  - Its presence is intentional to preserve **historical and contractual accuracy**.  
- **Keep `PAYMENT.amount`** since it may differ (installments, refunds, partial payments).  

---

##  Normalized Schema Summary (with noted exception)
- **USER(user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)**
- **PROPERTY(property_id, host_id, name, description, location, pricepernight, created_at, updated_at)**
- **BOOKING(booking_id, property_id, user_id, start_date, end_date, total_price*, status, created_at)**
  - *Note: `total_price` is **derived, not fundamental**, but kept intentionally for historical accuracy.*
- **PAYMENT(payment_id, booking_id, amount, payment_date, payment_method)**
- **REVIEW(review_id, property_id, user_id, rating, comment, created_at)**
- **MESSAGE(message_id, sender_id, recipient_id, message_body, sent_at)**

---
