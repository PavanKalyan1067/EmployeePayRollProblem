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