create table users_4 (
	id serial primary key,
	firstname varchar(50),
	lastname varchar(50),
	datelastorder date
)

create table orders_4 (
	id serial primary key,
	user_id int references users_4(id),
	dateOrder date
)

insert into users_4 (firstname, lastname, datelastorder)
values ('Dima','Korotkov','13-05-2023'),
('Vi','Krais','24-07-2023'),
('Vlad','Schin','05-03-2022'),
('Denis','Kochetkov','12-10-2022');

insert into orders_4(user_id, dateOrder) values
(floor(random()*(4-1))+1,'26-02-2022');
/*repeat last row 15 times*/

select user_id, max(dateOrder)
from orders_4
group by user_id;

create trigger updateLastOrder
before insert on orders_4
for each row
execute function updateLastOrder()

create or replace function updateLastOrder() returns trigger as $$
Begin
	update users_4
		set datelastorder = NEW.dateorder
		where id = NEW.user_id;
	return new;
end;
$$ language 'plpgsql'

select * from users_4 order by id;
insert into orders_4 (user_id, dateOrder) values
(3,'14-05-2023');