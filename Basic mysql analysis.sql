-- this is a self paced mysql project(Basic) --- 
create database Project;
use Project;
-------- Both tables taken from outsource data---------
select * from movies;
select * from movie_sales;

-- inner join movies and movie_sales table--
select Id, Title, Director, Year, Length_minutes, Movie_id, Rating, Domestic_sales, International_sales from movies inner join movie_sales on movies.id = movie_sales.Movie_id; 

-- queries-- 
-- Q1. find the domestic and international sales for each movie.
select title, Domestic_sales, International_sales from movies inner join movie_sales on movies.id = movie_sales.Movie_id;


-- Q2. Show the sales numbers of each movie who did better internatinally rather than domestically. 
select title, Domestic_sales, International_sales from movies inner join movie_sales on movies.id = movie_sales.Movie_id where International_sales > Domestic_sales;



-- Q3. List all the movies by there ratings in descending order. 
select Title, Rating from movies inner join movie_sales on movies.id = movie_sales.Movie_id order by Rating desc; 


-- right join movies and movie_sales table--
select Id, Title, Director, Year, Length_minutes, Movie_id, Rating, Domestic_sales, International_sales from movies right join movie_sales on movies.id = movie_sales.Movie_id order by Id asc; 

-- left join movies and movie_sales table--
select Id, Title, Director, Year, Length_minutes, Movie_id, Rating, Domestic_sales, International_sales from movies left join movie_sales on movies.id = movie_sales.Movie_id order by Id asc; 

-- Employee_Building table:

select * from employee; 

                                         --  Multi table queries --
-- Q1. find the list of all buildings that have employees 
select distinct Building from employee;

-- Q2. find the list of all buildings and their capacity. 
select * from building_capacity;

-- Q3. List all the buildings and its distinct employee rolls in each buildings (incliding empty buildings). 
select distinct Building_name, Role from Building_capacity left join employee on Building_name = Building;
                               
                               -- Null Values -- 
-- Q4. Find the name and roll of all employees who have not been assigned to a building. 
select name, Role from employee_building where Building is null;

-- Q5. Find the names of the building that hold no employees. 
-- (Wrong answer)select Building, Building_name from  employee_building left join building_capacity on Building = Building_name where building is null;

-- revised answer-- 
select distinct Building_name from Building_capacity left join employee on building_name = Building where Role is null;

											-- Expressions --
                                            -- Movies data & Movie_sales data -- 
                                            
-- Q6. List all movies and their combined sales in millions of dollars. 
select title, (Domestic_sales + International_sales) / 1000000 as Gross_sales_millions from movies inner join movie_sales on movies.id = movie_sales.Movie_id;

-- Q7. List all movies and their ratings in percent. 
select Title, Rating * 10 as Rating_prc from movies inner join movie_sales on movies.id = movie_sales.Movie_id; 

-- Q8. List all movies that were released on even number years. 
select title, year from movies where year%2 = 0 ;          

                                          -- Aggregate function --
                                          -- Employees data ---- 
-- Q9. Find the longest time that an employee has been in the studio. 
select name, max(Years_employed) as max_year_employed from employee group by name order by max_year_employed desc limit 1 ;

-- Q10. For each role, find the average number of  years employed by employees in that role. 
select role, avg(Years_employed)  as avg_year_employed from employee group by role  ;

-- Q11. find the total number of emloyee years worked in each building. 
select Building, sum(Years_employed)  as Total_year_employed from employee group by building; 

                                              -- Having clause -- 
                                              -- employee data -- 
                                              
-- Q12. Find the number of artists in the studio (without having clause). 
select role, count(*) as Number_of_artist from employee where role = "Artist";

-- Q13. Find the number of employees of each role in the studio. 
select role, count(*) as Number_of_artist from employee group by role;

-- Q14. Find the total number of years employed by all engineers. 
select role, sum(Years_employed) as ttl_year_employed_engineers from employee group by role having role = "Engineer" ;

										       -- Group By --- 
-- Q15. find the number of movies each director has directed.
select Director, count(Title) as Number_of_movies from movies group by Director;

-- Q16. Find the number of movies and total number of domestic and international sales that can be attributed to each director. 
select Director, count(Title), (Domestic_sales + International_sales) as ttl_Number_of_sales from movies inner join movie_sales on Id = Movie_id group by Director order by ttl_Number_of_sales desc;
                           
                                             
                                             -- Insert function -- 

-- Q17. Add the studio's new production, Toy story 4 to the list of movies( you can use any director). 
insert into movies( Id, Title, Director, Year, Length_minutes) values ("15", "Toy story 4", "Lee Unkrich", "2008", "123");
SELECT * FROM project.movies;


-- Q18. Toy story has been released to critical accliam! it had a rating of 8.7, and made 340 million-- 
--      domestically and 270 internationally add the record to the box office table. 
insert into movie_sales( Movie_id, Rating, Domestic_sales, International_sales) values ("15", "8.7", "340000000", "270000000");
SELECT * FROM project.movie_sales;

                                              
                                              -- Update --
                                              -- Movies data -- 
                                              
-- Q19. The director for the bug's life is incorrect it was actually directed by john ross. 
update movies set Director = "John ross" where title = "A Bug's Life"; 
SELECT * FROM project.movies;

-- Q20. The year that toy story2 was released is incorrect it was actually released in 1999.
update movies set Year = "1999" where title = "Toy Story 2"; 
SELECT * FROM project.movies;

-- Q21. Both the title and director for the Toy story 3 is incorrect. Title should be toy story 8 and it was directed by lee unkrich. 
update movies set title = "Toy Story 4", Director = "Lee Unkrich" where Title = "Toy story 3"; 
SELECT * FROM project.movies;


                                              -- Delete -- 
                                              
-- Q22. This data is getting too big lets remove all the movies which were released before 2005.
delete from movies where year < 2005; 
SELECT * FROM project.movies;

-- Q23. Andrew stanton has also left the studio so please remove all the movies directed by him. 
delete from movies where Director = "Andrew stanton"; 
SELECT * FROM project.movies;

