```mermaid
erDiagram
    USER {
        UUID user_id
        VARCHAR first_name
        VARCHAR last_name
        VARCHAR email
        VARCHAR password_hash
        VARCHAR phone_number
        role ENUM
        created_at TIMESTAMP
    }

    PROPERTY {
        UUID property_id
        UUID host_id
        VARCHAR name
        TEXT description
        VARCHAR location
        DECIMAL pricepernight
        created_at TIMESTAMP
        updated_at TIMESTAMP
    }

    BOOKING {
        UUID booking_id
        UUID property_id
        UUID user_id
        DATE start_date
        DATE end_date
        DECIMAL total_price
        status ENUM
        created_at TIMESTAMP
    }

    PAYMENT {
        UUID payment_id
        UUID booking_id
        DECIMAL amount
        payment_date TIMESTAMP
        payment_method ENUM
    }

    REVIEW {
        UUID review_id
        UUID property_id
        UUID user_id
        rating INTEGER
        comment TEXT
        created_at TIMESTAMP
    }

    MESSAGE {
        UUID message_id
        UUID sender_id
        UUID recipient_id
        message_body TEXT
        sent_at TIMESTAMP
    }

    %% Relationships with cardinalities
    USER ||--o{ PROPERTY : "1 hosts many"
    USER ||--o{ BOOKING : "1 makes many"
    USER ||--o{ REVIEW : "1 writes many"
    USER ||--o{ MESSAGE : "1 sends many"
    USER ||--o{ MESSAGE : "1 receives many"
    PROPERTY ||--o{ BOOKING : "1 has many"
    PROPERTY ||--o{ REVIEW : "1 receives many"
    BOOKING ||--o{ PAYMENT : "1 generates many"

