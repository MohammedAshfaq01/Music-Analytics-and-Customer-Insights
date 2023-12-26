-- Q1 : Who is the senior most employee on the job title


Select * From employee
ORDER BY levels desc
LIMIT 1

-- Q2 : Which countries has the most invoices?

Select COUNT(*), billing_country from invoice
group by billing_country
Order by COUNT desc

-- Q3 : What are the top 3 values of total invoice

Select * From invoice
Order By total desc
limit 3

-- Q4 Which city has the best customers ? We would like to throw a promotional music 
-- festival in the city we made the most money. Write a query that retuens a city that 
-- has biggest sum of invoice totals. return both city name and invoice totals 

Select Sum(total) as invoice_total , billing_city from invoice
group by billing_city 
Order by invoice_total desc


-- Q5 Who is the best customer ? Customer who has spent the most money will be declared
-- as the best customer. write a query that return the person who has spent most money.

Select customer.customer_id , customer.first_name , customer.last_name , SUM(invoice.total) as total 
from customer
Join invoice on customer.customer_id = invoice.customer_id
Group by customer.customer_id
Order by total desc
limit 1

/* Q2: We want to find out the most popular music Genre for each country. We determine the most popular genre as the genre 
with the highest amount of purchases. Write a query that returns each country along with the top Genre. For countries where 
the maximum number of purchases is shared return all Genres. */

SELECT DISTINCT email,first_name, last_name
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
WHERE track_id IN(
	SELECT track_id FROM track
	JOIN genre ON track.genre_id = genre.genre_id
	WHERE genre.name LIKE 'Rock'
)
ORDER BY email;

/* Q2: Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands. */

SELECT artist.artist_id, artist.name,COUNT(artist.artist_id) AS number_of_songs
FROM track
JOIN album ON album.album_id = track.album_id
JOIN artist ON artist.artist_id = album.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
GROUP BY artist.artist_id
ORDER BY number_of_songs DESC
LIMIT 10;

/* Q3: Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first. */

SELECT name,milliseconds
FROM track
WHERE milliseconds > (
	SELECT AVG(milliseconds) AS avg_track_length
	FROM track )
ORDER BY milliseconds DESC;

