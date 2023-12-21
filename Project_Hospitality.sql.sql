use project_hospitality;
select * from fact_bookings1;
select * from fact_aggregated_bookings1;
select * from dim_rooms1;
select * from dim_hotels1;
select * from dim_date1;
-- KPI-1
select sum(revenue_realized) as Total_Revenue from fact_bookings1;

-- KPI-2
select round(avg(occupancy),2) as Occupancy_Percentage from fact_aggregated_bookings1;

-- KPI-3
select count(booking_id) as Total_Booking from fact_bookings1;

-- KPI-4
select round (((select count(booking_status) from fact_bookings1 where booking_status="0") /count(booking_id)) *100,2)  as  Cancellation_Rate from fact_bookings1;

-- KPI-5
select count(booking_status) as Utilized_Capacity from fact_bookings1 where booking_status="1" ;

-- KPI-6
SET sql_mode=(SELECT REPLACE( @@sql_mode, 'ONLY_FULL_GROUP_BY',''));
select property_name as Hotel_Name,sum(successful_bookings) as Total_Bookings from fact_aggregated_bookings1 as fab inner join dim_hotels1 as dh on fab.property_id=dh.property_id group by property_name order by Total_Bookings desc;

-- KPI-7
select day_type as Day_Type,sum(revenue_realized) as Total_Revenue from fact_bookings1 as fb inner join dim_date1 as dd on fb.check_in_date=dd.check_in_date group by day_type order by Total_Revenue desc;

-- KPI-8
select day_type as Day_Type,count(booking_id) as Total_Booking from fact_bookings1 as fb inner join dim_date1 as dd on fb.check_in_date=dd.check_in_date group by day_type order by Total_Booking desc;


-- KPI-9
select state as State,sum(revenue_realized) as Total_Revenue from fact_bookings1 as fb inner join dim_hotels1 as dh on fb.property_id=dh.property_id group by state order by Total_Revenue desc;

-- KPI-10
select property_name as Hotel_Name,sum(revenue_realized) as Total_Revenue from fact_bookings1 as fb inner join dim_hotels1 as dh on fb.property_id=dh.property_id group by Hotel_Name order by Total_Revenue desc;

-- KPI-11
select room_class as Room_Type,sum(revenue_realized) as Total_Revenue from fact_bookings1 as fb inner join dim_rooms1 as dr on fb.room_category=dr.room_category group by Room_Type order by Total_Revenue desc;

-- KPI-12
select booking_status, count(booking_status) as Number_Of_Bookings  from fact_bookings1 group by booking_status order by booking_status;

-- KPI-13
select week_no as Week_No,sum(revenue_realized) as Total_Revenue,count(booking_id) as Total_Booking from fact_bookings1 as fb inner join dim_date1 as dd on fb.check_in_date=dd.check_in_date group by Week_No;
 

-- KPI-14
select property_name as Hotel_Name,round(avg(occupancy),2) as Avg_Occupancy_Rate from fact_aggregated_bookings1 as fab inner join dim_hotels1  as dh on fab.property_id=dh.property_id group by Hotel_Name order by Avg_Occupancy_Rate desc;

-- KPI-15
select room_class as Rooms_Type,round(avg(successful_bookings),2) as Avg_Successful_Bookings from fact_aggregated_bookings1 as fab inner join dim_rooms1 as dr on fab.room_category=dr.room_category group by Rooms_Type order by Avg_Successful_Bookings desc; 
















