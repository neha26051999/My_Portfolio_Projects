--STEP 1 CREATING DATABASE--
create database Spofity_data

---STEP 2 ANALYSIS 

--1.Give count of total artists--
select COUNT(distinct Artist) as total_artists
from Spotify_Tbl;

--2.What is avg monthly listeners?--
select avg(Monthly_Listeners_Millions )as Avg_Monthly_Listeners
from Spotify_Tbl

--3.What is the total number streams?--
select sum(Total_Streams_Millions) as total_number_of_streams_millions
from Spotify_Tbl

--4.What is total number of hours streamed?--
select sum(Total_Hours_Streamed_Millions) as total_number_of_hours_streams_millions
from Spotify_Tbl

--5.What is the number of streams last 30 days?---
select sum(Streams_Last_30_Days_Millions) as total_number_of_last_30_days_streams_millions
from Spotify_Tbl

--6.What is the avg skip rate?--
select avg(Skip_Rate) as avg_skip_rate
from Spotify_Tbl

--7. Show monthly listeners country wise--
select Country,Monthly_Listeners_Millions as Total_Monthly_Listeners_Millions
from Spotify_Tbl 
group by Country,Monthly_Listeners_Millions 
order by Total_Monthly_Listeners_Millions desc 

--8.Show average streams by company---
select Country,avg(Total_Streams_Millions) as avg_streams_millions
from Spotify_Tbl 
group by Country,Total_Streams_Millions
order by avg_streams_millions desc

--9.Which artist has highest and lowest streams?--
select top 1
Artist, SUM(Total_Streams_Millions) AS Total_Streams_Millions
from Spotify_Tbl
group by Artist
order by Total_Streams_Millions desc --highest--

select top 1
Artist, SUM(Total_Streams_Millions) AS Total_Streams_Millions
from Spotify_Tbl
group by Artist
order by Total_Streams_Millions asc --lowest--

--10.Which artist has highest average  skip rate?--
select top 1
Artist, avg(Skip_Rate) as avg_skip_rate
from Spotify_Tbl
group by Artist
order by avg_skip_rate desc --highest--

select top 1
Artist, avg(Skip_Rate) as avg_skip_rate
from Spotify_Tbl
group by Artist
order by avg_skip_rate asc --lowest--

--11.Which artist has highest and lowest streams in last 30 days?- 
select top 1
Artist,sum(Streams_Last_30_Days_Millions) as total_streams_millions  
from Spotify_Tbl
group by Artist
order by  total_streams_millions desc --highest--

select top 1
Artist,sum(Streams_Last_30_Days_Millions) as total_streams_millions  
from Spotify_Tbl
group by Artist
order by  total_streams_millions asc --lowest--
 
--12.Show monthly listeners for each album--
select Album,sum(Monthly_Listeners_Millions) as total_monthly_listeners
from Spotify_Tbl
group by Album
order by sum(Monthly_Listeners_Millions) desc

--13.Show total listeners for each album--
select Album,sum(Total_Streams_Millions) as total_streams_millions
from Spotify_Tbl
group by Album
order by sum(Total_Streams_Millions) asc

--14.Show total streams by genre--
select Genre,sum(Total_Streams_Millions) as total_streams_millions
from Spotify_Tbl
group by Genre
order by sum(Total_Streams_Millions) desc

--15.Show total number of releases--
select Release_Year,count(*) as number_of_releases
from Spotify_Tbl
group by Release_Year

--16.Show number of premium and free platform users--
select Platform_Type, count(*) as total_number_of_users
from Spotify_Tbl
group by Platform_Type

--17.Show trend of free and premium users overtime--
select Release_Year, Platform_Type, count(*) as Users_Count
from Spotify_Tbl
group by Release_Year, Platform_Type
order by Release_Year, Platform_Type;
















