create table users_3 (
	id int primary key,
	name varchar,
	age int
)

create table freinds (
	id_users int references users_3(id),
	id_friend int references users_3(id)
)

INSERT INTO users_3 
VALUES (1, 'Александр', 25),
       (2, 'Екатерина', 30),
       (3, 'Иван', 28),
       (4, 'Мария', 29),
       (5, 'Петр', 32);

INSERT INTO freinds 
VALUES (1, 2),
       (1, 3),
	   (1, 4),
	   (1, 5),
       (2, 3),
       (3, 4),
       (4, 5);
	   
create or replace function avgAgeFriends(int) returns 
table (user_id int, AvgAgeFriend real) as $$
	select id_users, avg(age)
	from freinds as f left join 
	users_3 as u on f.id_friend = u.id
	where id_users = $1
	group by id_users
$$ language sql

select * from avgAgeFriends(1);