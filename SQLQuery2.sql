--create a database
create database db;

--use database
use db;

--delete a table
drop table Employee;

--create a table
create table Employee(
	id int primary key,
	name varchar(20),
	salary float,
	joining_date date);

--insert values into a table
insert into Employee values (1,'Raj',20000,'2020-12-12');
insert into Employee values (2,'Dev',30000,'2021-12-10');
insert into Employee values (3,'Aditya',40000,'2020-11-12');
insert into Employee values (4,'Abhay',50000,'2019-12-1');
insert into Employee values (5,'Gaurav',60000,'2018-1-2');

insert into Employee values (6,'Abhinav',70000,'2017-11-2','Mumbai');

insert into Employee values (7,'Ayush',80000,'2015-9-3','Kolkata','CSE');

--show table records
select * from Employee;

--add column
alter table Employee add location varchar(20);

alter table Employee add dept varchar(20);

--add values to new column
update Employee set location='Pune' where id=1;
update Employee set location='Punjab' where id=2;
update Employee set location='Patna' where id=3;
update Employee set location='Delhi' where id=4;
update Employee set location='Noida' where id=5;
update Employee set salary=75500.55 where id=6;

update Employee set dept='CSE' where id<3;
update Employee set dept='ECE' where id>4;
update Employee set dept=null where id=3 or id=4; 

update Employee set salary=60000 where id=7;

--where
select name,salary from Employee where salary>20000;

--comparision operators
select * from Employee where salary=20000;

select salary from Employee where salary>=(select avg(salary) from Employee);

--logical operators
select * from employee where id>2 and salary < 50000;

select * from employee where location='pune' or salary > 40000;

select * from employee where not location='Pune';

--arithmetic operators
select salary,salary+1000 from employee where id=1;

select salary,salary*10 from employee;

--wildcard chars
select * from Employee where location like 'P%';
select * from Employee where name like '%r%';

select * from Employee where name like '_a%';

select * from Employee where location like '[ps]%';

select * from Employee where location like '[^ps]';
select * from Employee where location like '[^p^s]%';

--aggregate functions
select count(*) from Employee;

select sum(salary) as sum_salary from Employee;

select avg(salary) as avg_salary from Employee;

select min(salary) as min_salary from Employee;

select max(salary) as max_salary from Employee;

select round(salary,0) from Employee where id=6;

select floor(salary) from Employee where id=6;

select ceiling(salary) from Employee where id=6;

--string functions
select upper(name) from Employee;

select lower(name) from Employee;

select name,len(name) from Employee;

select name,replace(name,'b','a') from Employee;

select name,substring(name,1,3) from Employee;

--dateTime function
select getdate();

select joining_date,getdate(),datediff(year,joining_date,getdate()) from Employee;

select joining_date,dateadd(year,-5,joining_date) from Employee where id=1;
select joining_date,dateadd(day,+30,joining_date) from Employee where id=2;

select joining_date,datepart(day,joining_date) from Employee;

--order by
select * from Employee order by salary;

select * from Employee order by salary desc;

--group by
select dept,avg(salary) as avg_salary from employee group by dept;

select dept,sum(salary) from employee group by dept;

--distinct
select distinct salary from Employee;

select distinct dept from Employee;

--create table
create table Sales(
	sales_id int primary key,
	id int not null,
	item varchar(20),
	cost tinyint);

--drop table Sales;

--insert values into table
insert into Sales values(1,1,'Noodles',60);
insert into Sales values(2,1,'Vadapav',30);
insert into Sales values(3,2,'Noodles',60);
insert into Sales values(4,3,'Fried Rice',80);

select * from Sales;

--add foreign key
alter table Employee add constraint fk_id foreign key (id) references Sales(id);

--scaler function


--inline table value



--multi-statement table value



--join
select * from Employee;
select * from Sales;

select * from Employee inner join Sales on Employee.id = Sales.id;

select * from Employee left join Sales on Employee.id = Sales.id;

select * from Employee right join Sales on Employee.id = Sales.id;

select * from Employee full outer join Sales on Employee.id = Sales.id;

--drop table Project;

--create table
create table Project(
	project_id int primary key,
	id int not null,
	project_name varchar(20),
	project_loc varchar(20),
	foreign key(id) references Employee(id) on delete cascade on update cascade
	);

--insert values into table
insert into Project values (1,1,'Powertrain','Pune'),(2,2,'Body','Bangalore'),(3,3,'Idart','Kochi');

select * from Employee;
select * from Project;

delete from Employee where id=3;
--inner join
select * from Employee 
	inner join Sales on Employee.id = Sales.id
	inner join Project on Employee.id = Project.id;

--view
create view emp_view as 
	select * from project;
	
select * from emp_view;

--
select * from Employee;
select * from Sales;

select Employee.name,Sales.item from Employee inner join Sales on Employee.id=Sales.id where sales.item='Noodles';

--
select Employee.name,Sales.cost from Employee inner join Sales on Employee.id = Sales.id where sales.cost>=(select avg(cost) from Sales);

--
select Employee.name,Sales.item from Employee inner join Sales on Employee.id = Sales.id where sales.item like '[^n]%';

--
select item,(select name from Employee where Employee.id=Sales.id ) from Sales;

--
select Employee.id,Employee.joining_date,sales.item from sales inner join Employee on Employee.id = sales.id where datepart(month,joining_date) > 10;