-- 1
select max(employeename) as name, sum(totalamount) 
from orders as o left join employees as e on 
	e.employeeid = o.employeeid
group by e.employeeid
order by sum desc
limit 1;

--2
with cte as (
	select max(customername) as name, sum(totalamount) 
	from orders as o left join customers as e on 
		e.customerid = o.customerid
	group by e.customerid
), cte2 as (
	select *, sum(sum) over() as allSum from cte
)
select name, round((sum/allsum),2) as percent from cte2 

--3
select max(employeename) as name
from orders as o left join employees as e on 
	e.employeeid = o.employeeid
group by e.employeeid
having count(*) = 0