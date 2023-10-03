create table users_2_1 (
	id int primary key,
	name varchar,
	age int,
	city varchar
)

insert into users_2_1 values
(6,'Dima',20,'SPB'),
(7,'Vlad',26,'Sankt-Peterburg)'),
(8,'Dima',13,'Krasnodar'),
(9,'Vlad',29,'Vladivostok'),
(10,'Den',39,'Moskov');

create index idxnameusers on users_2_1(name);
drop index idxnameusers;
select name, city from users_2_1 where name = 'Den';