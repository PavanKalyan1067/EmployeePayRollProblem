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


------- UC 8: Add column department,PhoneNumber and Address -------
Alter table empoyee_payroll
add EmployeePhoneNumber BigInt,EmployeeDepartment varchar(200) not null default 'Publish',Address varchar(200) default 'Not Provided';

Update empoyee_payroll 
set EmployeePhoneNumber='1234567890',EmployeeDepartment='Civil',Address='Hyderabad,Telangana'
where name='Pavan';

Update empoyee_payroll 
set EmployeePhoneNumber='10987252525',EmployeeDepartment='Mechanical',Address='Arizona,US'
where name ='Kalyan';

Update empoyee_payroll 
set EmployeePhoneNumber='2134567890',EmployeeDepartment='IT',Address='Chennai,TN'
where name ='Yadav';

Update empoyee_payroll 
set EmployeePhoneNumber='3214567890',EmployeeDepartment='Irrigation',Address='Bareilly,UP'
where name ='Madhu';

------- UC 9: Rename Salary to Basic Pay and Add Deduction,Taxable pay, Income Pay , Netpay -------

EXEC sp_RENAME 'empoyee_payroll.Basic Pay' , 'BasicPay', 'COLUMN'
Alter table empoyee_payroll
add Deduction float,TaxablePay float, IncomeTax float,NetPay float;
Update empoyee_payroll  
set Deduction=2000
where Gender='M';
update empoyee_payroll
set NetPay=(BasicPay - Deduction)
update empoyee_payroll
set TaxablePay=0,IncomeTax=0
select * from empoyee_payroll;

------- UC 10: Adding another Value for Rujula in Editing Department -------

Insert into empoyee_Payroll(name,BasicPay,StartDate,Address,EmployeePhoneNumber,EmployeeDepartment) values ('Pranay',250000,'2019-04-20','Chennai,TN','43214567890','Transport');
select * from empoyee_payroll;