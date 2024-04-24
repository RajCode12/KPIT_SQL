create database newdb;
use newdb;

create table Employee(id int primary key, name varchar(20), salary int);

insert into Employee values(1,'Raj',20000);
insert into Employee values(2,'Dev',25000);
insert into Employee values(3,'Aditya',28000);

select * from Employee;
select * from Employee where salary>=25000;

select avg(salary) as avg_salary from Employee;
select min(salary) as min_salary from Employee;
select sum(salary) as sum_salary from Employee;
select max(salary) as max_salary from Employee;

update Employee set name=lower(name);
update Employee set name=upper(name);

create table Sales(id int primary key, item varchar(20), cost int);

insert into Sales values(1,'Vadapav',20);
insert into Sales values(2,'Noodles',80);
insert into Sales values(3,'Fried Rice',60);

select * from Sales;

alter table Employee add foreign key (id) references Sales(id);
--adding foreign key

--group by
select avg(salary) as avg_salary from Employee group by name;--dept

alter table Employee add dob date;

select * from Employee;

update Employee set dob='2002-11-11' where id=1;
update Employee set dob='2002-12-12' where id=2;
update Employee set dob='2002-10-10' where id=3;

--scaler function
drop function dbo.getName; 

create function dbo.getName(@id int)
returns varchar(20) 
as
begin
	return (select name from Employee where id=@id);
end;

select dbo.getName(2);

--inline table value function
create function dbo.getRecord(@sal int)
returns table
as
return (select * from Employee where salary>=@sal);

select dbo.getRecord(25000);
--mutli-line table value fucntion


select * from Employee inner join Sales on Employee.id=Sales.id;


