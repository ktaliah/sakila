use sakila;

# 1a
select first_name, last_name
from actor;

# 1b
select concat(first_name, ' ', last_name) as 'Actor Name'
from actor;

# 2a
select actor_id, first_name, last_name
from actor
where first_name = 'Joe';

# 2b
select first_name, last_name
from actor
where last_name like '%GEN%';

# 2c
select last_name, first_name
from actor
where last_name like '%LI%';

# 2d
select country_id, country
from country
where country in ('Afghanistan', 'Bangladesh', 'China');

# 3a
alter table actor
add Description blob;

# 3b
alter table actor
drop column Description;

# 4a
select last_name, count(last_name)
from actor
group by last_name;

# 4b
select last_name, count(last_name)
from actor
group by last_name
having count(last_name)>=2;

# 4c
update actor
set first_name = 'HARPO'
where first_name = 'GROUCHO' and last_name = 'WILLIAMS';

# 4d
update actor
set first_name = 'GROUCHO'
where first_name = 'HARPO' and last_name = 'WILLIAMS';

# 5a
show create table address;

# 6a
select s.first_name, s.last_name, a.address
from staff s
join address a on a.address_id = s.address_id;

# 6b
select s.first_name, s.last_name, sum(p.amount)
from payment p
join staff s on p.staff_id = s.staff_id
where p.payment_date like '2005-08%'
group by p.staff_id;

# 6c
select f.title, count(fa.actor_id)
from film f
join film_actor fa on f.film_id = fa.film_id
group by f.title;

# 6d
select f.title, count(i.film_id)
from film f
join inventory i on f.film_id = i.film_id
where f.title = 'Hunchback Impossible';

# 6e
select c.first_name, c.last_name, sum(p.amount)
from payment p
join customer c on p.customer_id = c.customer_id
group by p.customer_id
order by c.last_name;

# 7a
select title
from film
where (title like 'K%') or (title like 'Q%') and language_id in (
	select language_id
    from language
    where name = "english"
);

# 7b
select first_name, last_name
from actor
where actor_id in (
	select actor_id
	from film_actor
	where film_id in (
		select film_id
		from film
		where title = 'Alone Trip'
	)
);

# 7c
select cu.first_name, cu.last_name, cu.email
from customer cu
join address a on cu.address_id = a.address_id
join city ci on a.city_id = ci.city_id
join country co on ci.country_id = co.country_id
where co.country = 'Canada';

# 7d
select f.title, c.name
from category c
join film_category fc on c.category_id = fc.category_id
join film f on fc.film_id = f.film_id
where c.name = 'Family';

# 7e
select f.title, count(r.inventory_id)
from rental r
join inventory i  on r.inventory_id = i.inventory_id
join film f on i.film_id = f.film_id
group by f.title
order by count(r.inventory_id) desc;

# 7f
select sto.store_id, sum(p.amount)
from payment p
join staff sta on p.staff_id = sta.staff_id
join store sto on sta.store_id = sto.store_id
group by sto.store_id;
		
# 7g
select s.store_id, ci.city, co.country
from country co
join city ci on co.country_id = ci.country_id
join address a on ci.city_id = a.city_id
join store s on a.address_id = s.address_id
group by s.store_id;

# 7h
select c.name, sum(p.amount)
from category c
join film_category fc on c.category_id = fc.category_id
join inventory i on fc.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
join payment p on r.rental_id = p.rental_id
group by c.category_id
order by sum(p.amount) desc
limit 5;

# 8a
create view top_five_genres as
select c.name, sum(p.amount)
from category c
join film_category fc on c.category_id = fc.category_id
join inventory i on fc.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
join payment p on r.rental_id = p.rental_id
group by c.category_id
order by sum(p.amount) desc
limit 5;

# 8b
select * from top_five_genres;

# 8c
drop view if exists top_five_genres;