-- 1
select customer_id, count(*) 
from orders
where order_date > CURRENT_DATE - INTERVAL '1 year' 
group by customer_id;

-- 2
select product_name, round(avg(price),2), count(*)
from OrderedProducts as o left join Products as p
	on o.product_id = p.product_id
left join Orders as ord on o.order_id = ord.order_id
where order_date > CURRENT_DATE - INTERVAL '6 month'
group by product_name;

--3
select product_name
from products
where product_id not in (
	select distinct product_id
	from OrderedProducts as o 
		left join Orders as ord 
		on o.order_id = ord.order_id
	where order_date > CURRENT_DATE - INTERVAL '1 year'
)

--4
select supplier_name, count(*)
from orders as o left join orderedproducts as op 
	on o.order_id = op.order_id
left join products as p on op.product_id = p.product_id
left join suppliers as s on p.supplier_id = s.supplier_id
where order_date > CURRENT_DATE - INTERVAL '1 year'
group by supplier_name
order by count desc
limit 1
