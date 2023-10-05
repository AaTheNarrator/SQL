select product_name ,
	sum(amount) as sum,
	case when sum(amount) > 4300 then 'Популярный'
		else 'Непопулярный' end
from sales as s left join products as p 
	on s.product_id = p.product_id
where sale_date > CURRENT_DATE - INTERVAL '6 month'
group by product_name 
order by sum desc

---------------------------------------------------------

with cte as (
	select product_name, 
	sale_date,
	amount,
	sum(amount) over(
		partition by product_name, DATE_TRUNC('month', sale_date)
		order by sale_date
	) as suminmonth,
	row_number() over(
		partition by product_name, DATE_TRUNC('month', sale_date)
		order by sale_date
	) as dayinmonth
	from sales as s left join products as p 
		on s.product_id = p.product_id
	where s.product_id in (
		select product_id 
		from sales 
		where sale_date > CURRENT_DATE - INTERVAL '6 month'
		group by product_id 
		having sum(amount) > 4300
	)
)
select
	product_name,
    'Популярный' as segment,
	DATE_TRUNC('month', sale_date) as date,
	round(avg(amount),2),
	count(dayinmonth)
from cte
where suminmonth > 430
group by product_name, DATE_TRUNC('month', sale_date)
order by count desc


--------------------------------------------------------------
with cte as (
	select product_name, 
	sale_date,
	amount,
	sum(amount) over(
		partition by product_name, DATE_TRUNC('month', sale_date)
		order by sale_date
	) as suminmonth,
	row_number() over(
		partition by product_name, DATE_TRUNC('month', sale_date)
		order by sale_date
	) as dayinmonth
	from sales as s left join products as p 
		on s.product_id = p.product_id
	where s.product_id not in (
		select product_id 
		from sales 
		where sale_date > CURRENT_DATE - INTERVAL '6 month'
		group by product_id 
		having sum(amount) > 4300
	)
)
select
	product_name,
	'Непопулярный' as segment,
	DATE_TRUNC('month', sale_date) as date,
	round(avg(amount),2),
	count(dayinmonth)
from cte
where suminmonth > 43
group by product_name, DATE_TRUNC('month', sale_date)
order by count desc



