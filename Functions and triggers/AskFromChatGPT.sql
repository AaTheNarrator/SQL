/*create table*/

select * from employees order by employeeid;
create table employees (
	employeeID int primary key,
	firstname VARCHAR(50),
	lastname VARCHAR(50),
	salary int,
	Department VARCHAR(50),
	HireDate date
);

alter table employees
add column bonus real;

insert into employees values
(1,'Dima','Korotkov',120000,'first','19-09-2023'),
(2,'Vlad','Schin',115000,'second','12-10-2023'),
(3,'Viktoria','Krais',112000,'first','23-11-2021'),
(4,'Denis','Kochetkov',110000,'third','9-05-2024'),
(5,'Ali','Shahov',90000,'second','01-08-2023'),
(6,'Aihan','Dzhabrailov',130000,'second','02-04-2022');

update employees 
	set bonus = case when salary < 111000 then salary * 0.1
			when salary > 119000 then salary * 0.2
			else salary * 0.15 end
/*end create table*/

/*fuctions*/
create function CalculateBonus(int) returns real as $$
	select 
		case when salary < 111000 then salary * 0.1
			when salary > 119000 then salary * 0.2
			else salary * 0.15 end as bonus
	from employees
	where employeeid = $1
$$ language sql;

select CalculateBonus(6) as bonus;
/*end functions*/

/*trigger*/
Create or replace trigger UpdateSalaryTrigger
before update on employees
for each row
execute function UpdateSalaryTrigger();

create or replace function UpdateSalaryTrigger()
returns trigger as $$
Begin
	IF NEW.bonus > OLD.bonus THEN
		NEW.salary = NEW.salary + (NEW.bonus - OLD.bonus) * 0.05;
	ELSIF NEW.Bonus < OLD.Bonus THEN
		NEW.salary = NEW.salary - (OLD.bonus - NEW.bonus) * 0.05;
	end if;
	return new;
End;
$$ language 'plpgsql'
/*End trigger*/

/*Test*/
Update employees
	set bonus = 10000
	where employeeid = 4;
