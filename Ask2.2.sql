create table orders_2(
	id int,
	price decimal
)

insert into orders_2 
values
(floor(random()*(10-1))+1,floor(random()*(2500-100))+100);
/*repeat last row 75 times*/

create or replace function priceOfOrderById(int) 
returns table (id int, price decimal) as $$
	select id, sum(price)
	from orders_2
	where id = $1
	group by id
$$ language sql;

select * from orders_2 order by id;
select * from priceOfOrderById(1);