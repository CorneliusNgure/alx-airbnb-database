-- 1. Recreate a partitioned table by: 
-- dropping the unpartitioned one
DROP TABLE IF EXISTS bookings CASCADE;

-- 2. Create the partitioned table
CREATE TABLE bookings (
    booking_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL CHECK (status IN ('pending', 'confirmed', 'canceled')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_booking_property FOREIGN KEY (property_id) REFERENCES properties(property_id) ON DELETE CASCADE,
    CONSTRAINT fk_booking_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
) PARTITION BY RANGE (start_date);

-- 3. Create partitions (example: yearly partitions)
CREATE TABLE bookings_2023 PARTITION OF bookings
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE bookings_2024 PARTITION OF bookings
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE bookings_2025 PARTITION OF bookings
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- (Add more partitions as needed for future years)

-- 4. Test performance: Query with date filter (should scan only relevant partition)
EXPLAIN ANALYZE
SELECT 
    booking_id, property_id, user_id, start_date, end_date, status
FROM bookings
WHERE start_date BETWEEN '2024-06-01' AND '2024-06-30';

-- 5. Indexes on partitions (improves performance further)
CREATE INDEX idx_bookings_2023_user_id ON bookings_2023(user_id);
CREATE INDEX idx_bookings_2024_user_id ON bookings_2024(user_id);
CREATE INDEX idx_bookings_2025_user_id ON bookings_2025(user_id);