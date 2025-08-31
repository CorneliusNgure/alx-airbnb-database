```mermaid
erDiagram
    USER {
        UUID user_id PK
        VARCHAR first_name
        VARCHAR last_name
        VARCHAR email UNIQUE
        VARCHAR password_hash
        VARCHAR phone_number
        ENUM role
        TIMESTAMP created_at
    }

    PROPERTY {
        UUID property_id PK
        UUID host_id FK
        VARCHAR name
        TEXT description
        VARCHAR location
        DECIMAL pricepernight
        TIMESTAMP created_at
        TIMESTAMP updated_at
    }

    BOOKING {
        UUID booking_id PK
        UUID property_id FK
        UUID user_id FK
        DATE start_date
        DATE end_date
        DECIMAL total_price
        ENUM status
        TIMESTAMP created_at
    }

    PAYMENT {
        UUID payment_id PK
        UUID booking_id FK
        DECIMAL amount
        TIMESTAMP payment_date
        ENUM payment_method
    }

    REVIEW {
        UUID review_id PK
        UUID property_id FK
        UUID user_id FK
        INTEGER rating
        TEXT comment
        TIMESTAMP created_at
    }

    MESSAGE {
        UUID message_id PK
        UUID sender_id FK
        UUID recipient_id FK
        TEXT message_body
        TIMESTAMP sent_at
    }

    %% Relationships with explicit cardinalities
    USER ||--o{ PROPERTY : "1 hosts *"
    USER ||--o{ BOOKING : "1 makes *"
    USER ||--o{ REVIEW : "1 writes *"
    USER ||--o{ MESSAGE : "1 sends *"
    USER ||--o{ MESSAGE : "1 receives *"
    PROPERTY ||--o{ BOOKING : "1 has *"
    PROPERTY ||--o{ REVIEW : "1 receives *"
    BOOKING ||--o{ PAYMENT : "1 generates *"
