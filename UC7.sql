create database EmployeeServices;

--UC-2 creating Table
create Table empoyee_payrolls
(
id int identity(1,1) primary key,
name varchar(200) not null,
salary float,
startDate date
)
--UC-3 Insert values in Table
Insert into empoyee_payroll(name,salary,startDate) values
('Pavan',20000,'2021-03-12'),
('Kalyan',25000,'2021-04-18'),
('Yadav',10000,'2020-05-13'),
('Madhu',30000,'2020-08-19');

--UC-4 Retrieve All data--
select * from empoyee_payroll;

------- UC 5: Select Query using Cast() an GetDate() -------
select salary from empoyee_payroll where name='Pavan';
select salary from empoyee_payroll where startDate BETWEEN Cast('2020-12-20' as Date) and GetDate();

------- UC 6: Add Gender Column and Update Table Values -------
Alter table empoyee_payroll
add Gender char(1);

Update empoyee_payroll 
set Gender='M'
where name='Pavan';
Update empoyee_payroll 
set Gender='M'
where name='Kalyan' or name='Yadav'or name='Madhu';

------- UC 7: Use Aggregate Functions and Group by Gender -------

select Sum(salary) as "TotalSalary",Gender from empoyee_payroll group by Gender;
select Avg(salary) as "AverageSalary",Gender from empoyee_payroll group by Gender;
select Min(salary) as "MinimumSalary",Gender from empoyee_payroll group by Gender;
select Max(salary) as "MaximumSalary",Gender from empoyee_payroll group by Gender;
select count(salary) as "CountSalary",Gender from empoyee_payroll group by Gender;


