create table users_1(
	id serial primary key,
	firstname varchar,
	lastname varchar
)

create table orders_1(
	id serial primary key,
	user_id int references users_1(id)
)

insert into users_1 (firstname, lastname) 
values 
('Dima','Korotkov'),
('Vlad','Schin'),
('Vi','Krais'),
('Denis','Kochetkov'),
('Aykhan','Dzhabrailov'),
('Dima','Panov');

insert into orders_1 (user_id) 
values (floor(random()*(6-1))+1);

create or replace function countOrders(varchar,varchar) 
returns table (firstname Varchar, lastname varchar, countOrders int) as $$
	select $1, $2, count(*)
	from orders_1
	where user_id = (select id from users_1 where firstname = $1 and lastname = $2)
	group by user_id
$$ language sql

select o.id,firstname,lastname from orders_1 as o left join users_1 as u on o.user_id = u.id
select * from countOrders('Denis','Kochetkov');