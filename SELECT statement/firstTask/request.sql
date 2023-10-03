-- 1
with cte as (
	select max(first_name) as first_name,
	max(last_name) as last_name,
	sum(total_amount) as sum
	from orders as o left join customers as c on
		o.customer_id = c.customer_id
	group by o.customer_id
)
select *, dense_rank() over(order by sum desc) from cte

-- 2
with cte as (
	select max(first_name) as first_name,
	max(last_name) as last_name,
	round(avg(total_amount),2) as avg,
	sum(total_amount) as sum
	from orders as o left join customers as c on
		o.customer_id = c.customer_id
	group by o.customer_id
)
select *, dense_rank() over(order by avg desc, sum desc) from cte

-- 3
select max(first_name) as first_name,
max(last_name) as last_name
from orders as o left join customers as c on
	o.customer_id = c.customer_id
group by o.customer_id
having avg(total_amount) > (
	select avg(total_amount)
	from orders
)