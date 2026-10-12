create database if not exists company_ddbb;
use company_ddbb;
create table departments (   
  dept_id int primary key,
  dept_name varchar(50) not null unique,
  location varchar(50)
  );
create table employee (
     emp_id int primary key auto_increment,
     emp_name varchar(50) not null,
     salary decimal(10,2) not null,
     dept_id int,
     constraint fk_emp_dept
     foreign key (dept_id) references departments(dept_id)
     );
     insert into departments values
    (10, 'IT', 'delhi'),
     (20, 'HR', 'mumbai'),
     (30, 'finance','pune');
insert into employee (emp_id, emp_name, salary, dept_id) values
(1, 'aman', 40000, 10),
(2, 'bhavna', 55000,10),
(3, 'chetan', 30000,20),
(4, 'divya', 45000, 20),
(5,'esha', 60000, 30),
(6,'farhan', 35000, 30);
     select * from departments;
     select * from employee;
     select e.emp_name, e.salary, d.dept_name, d.location
     from employee e
     join departments d on e.dept_id = d.dept_id;
insert into employee (emp_name, salary, dept_id) values ('Hina', 30000, 99);
delete from departments where dept_id = 10;
 

delimiter $$

create function function_name (parameter1 int, parameter2 int)
returns returns int
deterministic  
begin
     declare variable_name int ;
     set variable_name = paremeter1 + parameter2;
     return variable_name;
end $$

delimeter ;
drop function if exists add_tax;
create function add_tax (p_price decimal(10,2))
returns decimal(10,2)
deterministic
return p_price * 1.18;
drop function if exists annual_salary;
delimiter $$
create function annual_sallary (p_emp_id int)
returns decimal (12,2)
reads sql data 
begin 
     declare v_salary decimal(10,2)
     select salary into v_salary
     from employee
     where emp_id = p_emp_id;
     return v_salary * 12;
     end $$
     delimiter; 
select annual_salary(1);
select emp_name, salary, annual_salary(emp_id) as yearly_salary from employee;
select annual_salary(99);
drop function if exists bad_salary;
delimiter $$
create function bad_salary (emp_id int)
returns decimal(12,2)
reads sql data
begin
 declare v_salary decimal(10,2);
 select salary into v_salary
 from employee
 where emp_id = emp_id;
 returns v_salary * 12;
end$$
delimiter ;
select bad_salary(3);
select salary into v_salary from employee where emp_id = 3;
select salary into @v_salary from employee where emp_id = 3;
select @v_salary as monthly, round(@v_salary * 12,2) as yearly;
rename table departments to department_tmp;
select annual_salary(1) as still_works;
drop function if exists dept_name_of;
delimiter $$
create function dept_name_of (p_dept_id int)
returns varchar (50)
reads sql data
begin
  declare v_name varchar(50);
  select dept_name into v_name
  from departments
  where dept_id = p_dept_id;
  return v_name;
  end $$
  delimiter;
select dept_name_of(10);
rename table department_tmp to department;
select dept_name_of(10) as works_again;
drop function if exists dept_name_of;
delimiter $$
create function dept_name_of (p_dept_id int)
returns varchar(50)
reads sql data
begin
   declare v_name varchar(50);
   select dept_name into v_name
   from department
   where dept_id = p_dept_id;
   return v_name;
end $$
delimiter ;
select dept_name_of(10);
select emp_name, dept_name_of(dept_id) as department from employee;
drop function if exists emp_count_in_dept;
delimiter $$
create function emp_count_in_dept (p_dept_id int)
returns int
reads sql data
begin
   declare v_count int;
   select count(*) into v_count
   from employee
   where dept_id = p_dept_id;
   return v_count;
end $$
delimiter ;
select emp_count_in_dept(10);
select dept_name, emp_count_in_dept(dept_id) as total_employee from department;
drop function if exists salary_grade;
delimiter $$
create function salary_grade (p_salary decimal(10,2))
returns varchar(10)
deterministic
begin
  declare v_grade varchar(10);
  if p_salary < 35000 then
    set v_grade = 'low';
  elseif p_salary < 50000 then
	set v_grade = 'medium';
  else 
    set v_grade = 'high';
end $$
delimiter ;
select emp_name, salary, salary_grade(salary) as grade from employee;
