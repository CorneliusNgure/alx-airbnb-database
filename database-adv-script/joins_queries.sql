SELECT * 
FROM bookings b
INNER JOIN users u
	on b.user_id = u.user_id;

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
