select distinct color as my_color
from shoes

select count(distinct color as num)
from shoes

#where color is not yellow red and black

#price is >10 and <10000

# brand ending with i

# price desc 

# add column name as my_favorite true
select *, true as my_favorite
from shoes
where not color in ('yellow','red','black')
and price > 10 and price < 15000 and not brand like '%i'
order by price desc
# order by must be the last

# notice that order by and count cannot exist at the same time
select count(*)as num
from shoes
where not color in ('yellow','red','black')
and price > 10 and price < 15000 and not brand like '%i'

# find opposite id, notice that where can followed by clause
select *
from shoes 
where id not in (
select id
from shoes
where not color in ('yellow','red','black')
and price > 10 and price < 15000 and not brand like '%i'
)

#counts customers after group on region rather than counting the whole table
select region, 
count(customerID) As total_customers 
from customers
group by region; #can have multiple columns, group by 

#where does not work for groups but for rows
#so use having to filter for groups
select customersID,
count (*) As orders
from orders
Group by customersID

#order by sorts data; group by doesnot sort data
select supplierID,
count (*) As num_prod
from Products
where UnitPrice >=4
Group by supplierID
HAVING COUNT (*) >=2; #having only used for aggregate fuction

#aggregate fuctions: avg count min max sum

#subquries
#joins

#kktest: find type which the largest price shoes price>1000
select brand
from shoes
group by brand
having max(price)>=1000;

#if price>100, select brand




#3/25/2020-KK TUTOR Time--find category, to satify no film-category have category, 
# 没有一个category被 film_category用到
select name
from category 
where category_id not in (
select category_id
from film_category)

select *
from film_category 
where category_id not in (
select category_id
from category)

# find customer rental most: 
select customer_id, count(customer_id) 
from rental  
group by customer_id 
having count(customer_id) = 

( 
select max(total_count) 
	from 
	(
select count(customer_id) as total_count
from rental 
group by customer_id
	) as foo)

# find first name end with 'y'
select *
from customer
where first_name like '%y'

# find Mary's address' city's country info

select country
from country
where country_id = 
(select country_id
from city
where city_id =
(select city_id
from address
where address_id =
(
select address_id
from customer
where first_name = 'Mary'
	)))

# find Mary rental from time now to earlier before 
select *
from rental
where customer_id =
(
select customer_id
from customer
where first_name = 'Mary'
	)
	order by rental_date desc

# find customer info who doesn't have rental 
select *
from customer
where customer_id not in(
select customer_id 
	from rental
)


# find 
select *
from film
where film_id in(
select film_id
from inventory
group by film_id
order by count(film_id) desc
limit 5)

#chapter join
select address_id,address, country.country_id, country, city.city_id, city, postal_code, phone
from city inner join country on city.country_id = country.country_id
inner join address on address.city_id = city.city_id

# find Mary's info
select first_name, last_name, address.address_id, address, country.country_id, country, city.city_id, city, postal_code, phone
from city inner join country on city.country_id = country.country_id
inner join address on address.city_id = city.city_id inner join customer on customer.address_id = address.address_id
where first_name = 'Mary'

# which is the most popular film. list out top 5
select film.film_id, title, count(film.film_id) as total_rent
from film inner join inventory on film.film_id = inventory.film_id
inner join rental on inventory.inventory_id = rental.inventory_id
group by film.film_id
order by count(film.film_id) desc
limit 5

# top 10 customers' name who consume more than 100
select first_name, last_name, customer.customer_id, sum(amount)
from customer inner join rental on customer.customer_id = rental.customer_id
inner join payment on rental.rental_id = payment.rental_id
group by customer.customer_id
having sum(amount)>190
order by sum(amount) desc  #!!!!!order by must be the last


#aliases



#Self Join Example (The following SQL statement matches customers that are from the same city:
SELECT A.CustomerName AS
CustomerNamel, B.CustomerName AS
CustomerNameZ, A.City
FROM Customers A, Customers 8
WHERE A.CustomerID = B.CustomerID
AND A.City = B.City
ORDER BY A.City;


#left joins-ALL customer list customer first and order first will get different
SELECT C.CustomerName, O.OrderID
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID
= O.CustomerID
ORDER BY C.CustomerName;

#right join
SELECT Orders.OrderID, 
Employee.lastName,
Employee.FirstName
FROM Orders
RIGHT JOIN Employees ON 
Orders.EmployeeID =
Employees.EmployeeID
ORDER BY Orders.OrderID;

#full outer join: For the full outer join, this will return all the records 
#where there is a match in either table 1 or there's a match in table 2. 
#So this is just saying, hey, just return and give me everything whether there's matching one or matching two.

#unions - safe a lot of time
SELECT City, Country FROM 
Customers
WHERE Country ='Germany'
UNION
SELECT City, Country FROM 
Suppliers
WHERE Country ='Germany'
ORDER BY City;

#a few quick things you can do to start to make sure that our joins are working well. 
#One, check the number of records you have each time you make a new join. 
#Did you lose any records? Did you gain any record you weren't expecting? 
#And then the other thing, is to look for duplicates. 
#So, as you start to join more and more tables together, it's going to get more complex. So really start small. 
#Start with just one table, check it, and add another table. Check it and move on from there.

#modify strings by 
#concatenating 
SELECT CompanyName,
ContactName,
CompanyName || '('|| ContactName||')'
FROM 
Customers

#trimming
SELECT TRIM(" You the best. ")
AS TrimmedString;

#substring function -- pull apart just a portion of the string that you're looking at. 
SUBSRT(string name, string 
position, number of 
characters to be returned);
SELECT first_name, SUBSRT
(first_name, 2, 3)
FROM employees
WHERE department_id = 60;

#changing the case
SELECT UPPER(column_name) FROM table_name;
SELECT LOWER(column_name) FROM table_name;
SELECT UCASE(column_name) FROM table_name;

#SQLite supports five date and time functions as follows:

date(timestring, modifier, modifier, ...)
time(timestring, modifier, modifier, ...)
datetime(timestring, modifier, modifier, ...)
julianday(timestring, modifier, modifier, ...)
strftime(format, timestring, modifier, modifier, ...)

modifier ???


#Compute current date
SELECT DATE('now')

#compute the year, month, and day from the current date.
SELECT STRFTIME('%Y %m %d' , 'now')

#Compute hour, minute, second, and millisecond for that time
SELECT STRFTIME('%H %M %S %s' , 'now')

#Compute age useing birthdate
SELECT Birthdate
, STRFTIME('%Y', Birthdate) AS Year
, STRFTIME('%m', Birthdate) AS Month
, STRFTIME('%d', Birthdate) AS Day
, DATE(('now') - Birthdate) AS Age
FROM employees

#So you're taking parts of that time stamp 
and computing maybe a second of time 
because you want to aggregate on that. 
For example, do we see a high volume of 
hits to our website at an individual 
second or is it over the span of a certain hour?

#search case statement
SELECT 
trackid, name, bytes, 
,CASE
WHEN bytes < 300000 THEN 'small'
WHEN bytes >= 300000 AND bytes <= 500000 THEN 'medium'
WHEN bytes >= 500001 THEN 'large'
ELSE 'Other'
END bytescategory
FROM 
tracks;
#. You could leave this blank and it will just classify
#back as a null. But this was just in case there wasn't something I caught. 

#View
CREATE VIEW my_view
AS
SELECT
r.regiondescription
, t.territorydescription
, e.lastName
, e.FirstName
, e.Hiredate
, e.Reportsto
FROM Region r
INNER JOIN territories t on r.regionid = t.regionid 
INNER JOIN Employeeterritories et on t.TerritoryID = et.TerritoryID
INNER JOIN Employees e on et.employeeid = e.EmployeeID

SELECT *
FROM my_view
DROP VIEW my_view;



