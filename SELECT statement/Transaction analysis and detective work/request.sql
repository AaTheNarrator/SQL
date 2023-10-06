select user_id, sum(amount)
from transactions
where timestamp > CURRENT_DATE - INTERVAL '7 days'
group by user_id
having sum(amount) > 10000
order by sum desc

------------------------------------------

with cte as (
	select user_id,timestamp, sum(amount)
	from transactions
	where timestamp > CURRENT_DATE - INTERVAL '1 month'
	group by user_id, timestamp
)
select user_id, round(avg(sum),2) as avg
from cte
group by user_id
having avg(sum) > 2000


-------------------------------------------

with cte as (
	select *,
		lead(amount) over(
			partition by user_id
			order by timestamp asc
		) as next_amount
	from transactions
), cte2 as (
	select distinct c.user_id
	from cte as c left join users as u on c.user_id = u.user_id
	where abs(amount - next_amount) > 3000
)
select * 
from users 
where user_id in (
	select * 
	from cte2
)

--------------------------------------------

with cte as (
	select *,
		lead(timestamp) over(
			partition by user_id
			order by timestamp asc
		) as next_timestamp
	from transactions
)
select transaction_id, (next_timestamp - timestamp) as days 
from cte
where (next_timestamp - timestamp) > (
	select avg(next_timestamp - timestamp)
	from cte
) + INTERVAL '2 day'

