use hospitality_project;
show tables;
use hospitality_project;
SELECT * FROM dim_hotels LIMIT 5;
SELECT COUNT(*) AS total_rows FROM dim_hotels;
SELECT COUNT(*) AS total_rows FROM fact_bookings;
SELECT * FROM fact_bookings limit 5;
SELECT SUM(revenue_realized) AS total_revenue 
   FROM fact_bookings 
   WHERE booking_status = 'Checked Out';
      SELECT 
       h.property_name,
       h.city,
       SUM(f.revenue_realized) AS total_revenue
   FROM fact_bookings f
   JOIN dim_hotels h ON f.property_id = h.property_id
   WHERE f.booking_status = 'Checked Out'
   GROUP BY h.property_name, h.city
   ORDER BY total_revenue DESC;
   SELECT 
    booking_status,
    COUNT(*) AS total_bookings,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM fact_bookings), 2) AS percentage
FROM fact_bookings
GROUP BY booking_status;
SELECT 
    h.property_name,
    ROUND(AVG(f.revenue_realized), 0) AS avg_booking_value
FROM fact_bookings f
JOIN dim_hotels h ON f.property_id = h.property_id
WHERE f.booking_status = 'Checked Out'
GROUP BY h.property_name
ORDER BY avg_booking_value DESC;
SELECT 
    h.property_name,
    f.room_category,
    COUNT(*) AS total_bookings,
    ROUND(AVG(f.revenue_realized), 0) AS avg_revenue
FROM fact_bookings f
JOIN dim_hotels h ON f.property_id = h.property_id
WHERE f.booking_status = 'Checked Out'
GROUP BY h.property_name, f.room_category
ORDER BY h.property_name, avg_revenue DESC;
SELECT 
    booking_platform,
    COUNT(*) AS bookings,
    SUM(revenue_realized) AS total_revenue
FROM fact_bookings
WHERE booking_status = 'Checked Out'
GROUP BY booking_platform
ORDER BY total_revenue DESC;
SELECT 
    f.room_category,
    COUNT(*) AS bookings,
    ROUND(AVG(f.revenue_realized), 0) AS avg_revenue
FROM fact_bookings f
JOIN dim_hotels h ON f.property_id = h.property_id
WHERE h.property_name = 'Atliq Exotica' 
  AND f.booking_status = 'Checked Out'
GROUP BY f.room_category
ORDER BY avg_revenue DESC;
SELECT 
    f.room_category,
    COUNT(*) AS bookings,
    SUM(f.revenue_realized) AS total_revenue
FROM fact_bookings f
JOIN dim_hotels h ON f.property_id = h.property_id
WHERE h.property_name = 'Atliq Exotica' 
  AND f.booking_status = 'Checked Out'
GROUP BY f.room_category
ORDER BY total_revenue DESC;
SELECT 
    h.property_name,
    f.booking_status,
    COUNT(*) AS bookings
FROM fact_bookings f  
JOIN dim_hotels h ON f.property_id = h.property_id
GROUP BY h.property_name, f.booking_status
ORDER BY h.property_name, bookings DESC;
SELECT 
    h.property_name,
    SUM(CASE WHEN f.booking_status = 'Checked Out' THEN 1 ELSE 0 END) AS completed,
    SUM(CASE WHEN f.booking_status = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled,
    SUM(CASE WHEN f.booking_status = 'No Show' THEN 1 ELSE 0 END) AS no_show,
    COUNT(*) AS total_bookings,
    ROUND(SUM(CASE WHEN f.booking_status = 'Cancelled' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS cancel_pct
FROM fact_bookings f
JOIN dim_hotels h ON f.property_id = h.property_id
GROUP BY h.property_name
ORDER BY cancel_pct DESC;
SELECT 
    h.property_name,
    SUM(f.revenue_realized) AS actual_revenue,
    SUM(f.revenue_generated) AS potential_revenue,
    SUM(f.revenue_generated) - SUM(f.revenue_realized) AS lost_revenue
FROM fact_bookings f
JOIN dim_hotels h ON f.property_id = h.property_id
GROUP BY h.property_name
ORDER BY lost_revenue DESC;
SELECT 
    booking_platform,
    ROUND(SUM(CASE WHEN booking_status = 'Cancelled' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS cancel_pct
FROM fact_bookings
GROUP BY booking_platform
HAVING COUNT(*) > 5
ORDER BY cancel_pct DESC;
SELECT 
    booking_platform,
    COUNT(*) AS total_bookings,
    SUM(CASE WHEN booking_status = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled,
    ROUND(SUM(CASE WHEN booking_status = 'Cancelled' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS cancel_pct,
    SUM(revenue_realized) AS actual_revenue,
    SUM(revenue_generated) AS potential_revenue
FROM fact_bookings
GROUP BY booking_platform
HAVING COUNT(*) > 5
ORDER BY potential_revenue - actual_revenue DESC;
use hospitality_project;
SELECT ROUND(SUM(successful_bookings) * 100.0 / SUM(capacity), 2) AS occupancy_pct
FROM fact_aggregated_bookings;
SELECT 
    ROUND(
        2061680 / 9995
    , 0) AS RevPAR;
    SELECT 
    ROUND(
        (SELECT SUM(revenue_realized) FROM fact_bookings WHERE booking_status = 'Checked Out') 
        / 
        (SELECT SUM(capacity) FROM fact_aggregated_bookings)
    , 0) AS RevPAR;
    SELECT 
    ROUND(
        2061680 / (SELECT SUM(successful_bookings) FROM fact_aggregated_bookings)
    , 0) AS ADR;




