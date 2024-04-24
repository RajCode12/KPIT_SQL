--
create database db1;

--
use db1;

--
create table Student(
	id int primary key,
	firstName varchar(20) not null,
	lastName varchar(20),
	age int not null,
	gpa decimal);

--
insert into Student values (1,'John','Smith',20,3.75)
insert into Student values (2,'Emily','Johnson',22,3.90)
insert into Student values (3,'Michael','Davis',21,3.60)

--
select * from Student;

--
create table Courses(
	course_id int primary key,
	course_name varchar(20),
	credits int);

--
insert into Courses values (101,'Mathematics',3), (102,'History',4), (103,'Computer Science',3);
	
--
select * from Courses;

--
create table Enrollments(
	enroll_id int primary key,
	student_id int,
	course_id int,
	enroll_date datetime,
	foreign key (student_id) references Student(id) on delete cascade on update cascade,
	foreign key (course_id) references Courses(course_id) on delete cascade on update cascade
	);

--
insert into Enrollments values (1,1,101,'2023-01-15 10:30:00');
insert into Enrollments values (2,2,102,'2023-02-20 14:45:00');
insert into Enrollments values (3,1,103,'2023-03-05 02:15:00');

--
select * from Student;
select * from Enrollments;
select * from Courses;

--1.
select concat(firstName,' ',lastName),gpa from Student where gpa > 3.7;

--2.
select sum(Courses.credits) from Courses
	inner join Enrollments on Courses.course_id = Enrollments.course_id
	inner join Student on Enrollments.student_id = Student.id group by Courses.credits;

--3.
select Student.firstName from Student 
	inner join Enrollments on Student.id = Enrollments.student_id
	inner join Courses on Enrollments.course_id = Courses.course_id 
	where Courses.course_name = 'Mathematics';

--4.
select Student.age from Student 
	inner join Enrollments on Student.id = Enrollments.student_id
	inner join Courses on Enrollments.course_id = Courses.course_id
	where Courses.course_name = 'Computer Science'; 
	
--5.
update Student set gpa=gpa+0.1;

--6.
select Courses.course_name from Courses
	inner join Enrollments on Courses.course_id = Enrollments.course_id 
	inner join Student on Enrollments.student_id = Student.id	
	where Enrollments.enroll_id = (select count(enroll_id) from Enrollments);

------------------------------------------------------------------------------------

--
create table Customers (
	id int primary key,
	firstName varchar(20),
	lastName varchar(20),
	email varchar(20),
	reg_date date);

--
insert into Customers values (1,'John','Doe','john@example.com','2023-01-10');
insert into Customers values (2,'Jane','Smith','smith@example.com','2023-02-15');
insert into Customers values (3,'Michael','Doe','michael@example.com','2023-03-10');

--
select * from Customers;

--
create table Orders(
	order_id int primary key,
	customer_id int,
	order_date datetime,
	totalAmount decimal);

--
insert into Orders values (101,1,'2023-01-15 10:30:00',150.00);
insert into Orders values (102,2,'2023-02-20 14:45:00',200.00);
insert into Orders values (103,1,'2023-03-05 08:15:00',75.00);

--
select * from Orders;

--
create table Products(
	prod_id int primary key,
	prod_name varchar(20),
	price decimal,
	quantity int);

--
insert into Products values (1001,'Widget A',25.00,50),(1002,'Widget B',30.00,75),(1003,'Widget C',20.00,30);

--
select * from Products;

--1.
select Customers.firstName from Customers
	inner join Orders on Customers.id = Orders.customer_id
	where datepart(month,Orders.order_date) = 2 and datepart(year,Orders.order_date) = 2023;

--2.
select Customers.firstName,sum(Orders.totalAmount) from Orders 
	inner join Customers on Orders.customer_id = Customers.id
	group by Customers.firstName;

--3.
select * from Products where price > 25 and quantity > 50;

--4.
select avg(totalAmount) from Orders where datepart(month,order_date) = 1 and datepart(year,order_date) = 2023;

--5.
update Products set price = 30.00 where prod_name = 'Widget A';

--6.
select Customers.firstName from Customers
	inner join Orders on Customers.id = Orders.customer_id
	where Orders.totalAmount = (select max(totalAmount) from Orders) group by Customers.firstName;

------------------------------------------------------------------------------------

--
create database db2;

--
use db2;

--
create table Products(
	prod_id int,
	prod_name varchar(20),
	category_id int,
	price decimal,
	quantity int);

--
insert into Products values (1,'Laptop',1,800.00,10),(2,'Smartphone',1,500.00,20),(3,'Monitor',2,250.00,15);

--
select * from Products;

--
create table Category(
	category_id int,
	category_name varchar(20));

--
insert into Category values (1,'Electronics'),(2,'Peripherals'),(3,'Furniture');

--
select * from Category;

--
create table Orders(
	order_id int primary key,
	customer_id int,
	order_date datetime,
	totalAmount decimal);

--
insert into Orders values (101,1,'2023-01-15 10:30:00',1500.00);
insert into Orders values (102,2,'2023-02-20 14:45:00',800.00);
insert into Orders values (103,1,'2023-03-05 08:15:00',450.00);

--
select * from Products;
select * from Category;
select * from Orders;

--1.
select Products.prod_name from Products 
	inner join Category on Products.category_id = Category.category_id
	where Category.category_name = 'Electronics';

--2.
select Products.prod_name,Products.price from Products
	inner join Category on Products.category_id = Category.category_id
	where Products.price = (select max(price) from Products);

--3.
select * from Products where price>300 and quantity>5;

--4.
select avg(totalAmount) from Orders where datepart(month,order_date) = 2 and datepart(year,order_date) = 2023;

--5.
update Products set quantity=15 where prod_name='Laptop';

--6.
select top 1 customer_id,sum(totalAmount) as total from Orders group by customer_id order by sum(totalAmount) desc;

-----------------------------------------------------------------------------------------

--
create table Employee(
	emp_id int primary key,
	firstName varchar(20),
	lastName varchar(20),
	dept_id int,
	salary decimal);

--
insert into Employee values (1,'John','Doe',101,60000.00),(2,'Jane','Smith',102,55000.00),(3,'Michael','Johnson',101,65000.00);

--
select * from Employee;

--
create table Department(
	dept_id int primary key,
	dept_name varchar(20));

--
insert into Department values (101,'Sales'),(102,'Marketing'),(103,'Finance');

--
select * from Department;

--
select * from Employee;
select * from Department;
select * from Orders;

--1.
select concat(firstName,' ',lastName),salary from Employee 
	inner join Department on Employee.dept_id = Department.dept_id
	where Department.dept_name = 'Sales';

--2.
select Employee.emp_id,sum(Orders.totalAmount) from Orders
	inner join Employee on Orders.customer_id = Employee.emp_id
	where Employee.dept_id = (select dept_id from Department where dept_name = 'Sales') group by Employee.emp_id;

--3.
select * from Employee 
	inner join Department on Employee.dept_id = Department.dept_id
	where Department.dept_name = 'Marketing' and Employee.salary >= 55000;

--4.
select avg(totalAmount) from orders where datepart(month,order_date) = 2 and datepart(year,order_date) = 2023;

--5.
update Employee set salary = 65000 where firstName = 'John' and lastName = 'Doe';

--6.
select Department.dept_name,avg(Employee.salary) as avgSalary from Employee
	join Department on Employee.dept_id = Department.dept_id
	group by Department.dept_name order by avgSalary desc;
	
--------------------------------------------------------------------------------------------

--
create table Student(
	student_id int primary key,
	firstName varchar(20),
	lastName varchar(20),
	age int,
	gpa decimal);

--
insert into Student values (1,'John','Doe',23,2.5),(2,'Jane','Smith',21,4.3),(3,'Alice','Johnson',20,4.2),(4,'Bob','Williams',24,3.6);

--
select * from Student;

--
create table Courses(
	course_id int primary key,
	course_name varchar(20),
	instructor varchar(20),
	credit int);

--
insert into Courses values (1,'Database','Dr Smith',3),(2,'Data Structure','Prof Johnson',4),(3,'Software Eng','Dr Brown',5);

--
select * from Courses;

--
create table Enrollment(
	enroll_id int primary key,
	student_id int,
	course_id int,
	enroll_date date);

--
insert into Enrollment values (1,1,1,'2023-08-01'),(2,1,2,'2023-06-01'),(3,2,2,'2023-08-02'),
	(4,3,3,'2023-08-03'),(5,4,1,'2023-08-04');

--
select * from Student;
select * from Courses;
select * from Enrollment;

--1.
select * from Student where age > 20;

--2.
select avg(gpa) as avg_gpa from Student;

--3.
select course_name,instructor from Courses;

--4.
select top 3 course_name,credit from Courses order by credit desc;

--5.
select Student.firstName,Courses.course_name,Courses.instructor from Student
	inner join Enrollment on Student.student_id = Enrollment.student_id 
	inner join Courses on Enrollment.course_id = Courses.course_id;

--------------------------------------------------------------------------------------------------------