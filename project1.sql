use project;
-- 1How do you retrieve the total revenue realized from the fact_bookings table?
Select SUM(revenue_realized) AS Total_Revenue_Realized
FROM fact_bookings;

-- 2.How do you determine the total number of bookings that have occurred?
SELECT COUNT(*) AS Total_Bookings
FROM fact_bookings;

-- 3. How do you calculate the total capacity of rooms present in all hotels?
SELECT SUM(capacity) AS Total_Room_Capacity
FROM fact_aggregated_bookings;

-- 4.How do you determine the total number of successful bookings that have occurred across all hotels?
SELECT SUM(successful_bookings) AS Total_Successful_Bookings
FROM fact_aggregated_bookings;

-- 5 .How do you calculate the occupancy rate, defined as the ratio of total successful bookings to the total rooms available (capacity), across all hotels?
SELECT SUM(successful_bookings) / SUM(capacity) * 100 AS Occupancy_Rate
FROM fact_aggregated_bookings;

-- 6 How do you calculate the average ratings given by customers for hotel services?
SELECT AVG(ratings_given) AS Average_Rating
FROM fact_bookings;

-- 7How many days of data are present in the dataset from May to July?##
SELECT DATEDIFF('2024-07-31', '2024-05-01') + 1 AS total_days;

-- 8.How do you calculate the total number of "Cancelled" bookings as a proportion of all bookings that have occurred?
SELECT COUNT(*) AS Total_Cancelled_Bookings
FROM fact_bookings
WHERE booking_status = 'Cancelled';

-- 9.How do you calculate the cancellation percentage, defined as the ratio of cancelled bookings to total bookings?
SELECT (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM fact_bookings)) AS Cancellation_Percentage
FROM fact_bookings
WHERE booking_status = 'Cancelled';

-- 10.How do you calculate the total number of successful 'Checked out' bookings as a proportion of all bookings that have occurred?
SELECT COUNT(*) AS Total_Checked_Out_Bookings
FROM fact_bookings
WHERE booking_status = 'Checked Out';

-- 11.How do you calculate the total number of "No Show" bookings, defined as bookings where customers neither cancelled nor attended their booked rooms, as a proportion of all bookings that have occurred?
SELECT COUNT(*) AS Total_No_Show_Bookings
FROM fact_bookings
WHERE booking_status = 'No Show';

-- 12.How do you calculate the no show percentage, defined as the ratio of "No Show" bookings to total bookings?
SELECT (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM fact_bookings)) AS No_Show_Percentage
FROM fact_bookings
WHERE booking_status = 'No Show';

-- 13.How do you calculate the percentage contribution of each booking platform for bookings in hotels?
SELECT 
    booking_platform, 
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM fact_bookings) AS Booking_Platform_Contribution_Percentage
FROM 
    fact_bookings
GROUP BY 
    booking_platform;
    
-- 14. How do you calculate the percentage contribution of each room class over the total rooms booked?
SELECT 
    room_class, 
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM fact_bookings) AS Room_Class_Contribution_Percentage
FROM 
    fact_bookings fb
JOIN 
    dim_rooms dr ON fb.room_category = dr.room_id
GROUP BY 
    room_class;   
    
-- 15. How do you calculate the Average Daily Rate (ADR), defined as the ratio of revenue to the total rooms booked/sold?
SELECT 
    SUM(revenue_realized) / COUNT(DISTINCT check_in_date) AS ADR
FROM 
    fact_bookings; 
    
-- 16.How do you calculate the realization percentage, defined as the percentage of successful "Checked Out" bookings over all bookings that have occurred?
SELECT 
    (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM fact_bookings WHERE booking_status IN ('Checked Out', 'No Show'))) AS Realization_Percentage
FROM 
    fact_bookings
WHERE 
    booking_status = 'Checked Out';
    
-- 17.How do you calculate the Revenue Per Available Room (RevPAR), representing the revenue generated per available room, regardless of whether they are occupied?
SELECT 
    SUM(revenue_realized) / SUM(capacity) AS RevPAR
FROM 
    fact_bookings fb
JOIN 
    fact_aggregated_bookings fab ON fb.property_id = fab.property_id; 
    
-- ##18.How do you calculate the Daily Booked Room Nights (DBRN), which indicates on average how many rooms are booked per day over a specific time period?
SELECT 
    SUM(successful_bookings) / DATEDIFF(MAX(check_in_date), MIN(check_in_date)) AS DBRN
FROM 
    fact_aggregated_bookings;
    
-- 19.How do you calculate the Daily Sellable Room Nights (DSRN), which represents on average how many rooms are available for sale per day over a specific time period?
SELECT 
    SUM(capacity) / DATEDIFF(MAX(check_in_date), MIN(check_in_date)) AS DSRN
FROM 
    fact_aggregated_bookings;
    
-- ##20 How do you calculate the Daily Utilized Room Nights (DURN), representing on average how many rooms are successfully utilized by customers per day over a specific time period?
SELECT 
    SUM(successful_bookings) / DATEDIFF(MAX(check_out_date), MIN(check_in_date)) AS DURN
FROM 
    fact_bookings;
    
 