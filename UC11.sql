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

------- UC 11: Implement the ER Diagram into Payroll Service DB -------
--Create Table for Company
Create Table Company
(CompanyID int identity(1,1) primary key,
CompanyName varchar(100))
--Insert Values in Company
Insert into Company values ('TCS'),('TECHM')
Select * from Company

--Create Employee Table
drop table empoyee_payroll
create table Employee
(EmployeeID int identity(1,1) primary key,
CompanyIdentity int,
EmployeeName varchar(200),
EmployeePhoneNumber bigInt,
EmployeeAddress varchar(200),
StartDate date,
Gender char,
Foreign key (CompanyIdentity) references Company(CompanyID)
)
--Insert Values in Employee
insert into Employee values
(1,'Karthin',9999905050,'5-124, Ghanpur,506757','2012-03-28','M'),
(2,'Kriti ',9000005550,'2332, Parkal, 506757','2017-04-22','F'),
(1,'Raju',7812905050,'Bernard Shaw, Georgia,132001 ','2015-08-22','M'),
(2,'Ramu',78129050000,'Bernard Shaw, PB Marg Bareilly','2012-08-29','M')

Select * from Employee

--Create Payroll Table
create table PayrollCalculate
(BasicPay float,
Deductions float,
TaxablePay float,
IncomeTax float,
NetPay float,
EmployeeIdentity int,
Foreign key (EmployeeIdentity) references Employee(EmployeeID)
)
--Insert Values in Payroll Table
insert into PayrollCalculate(BasicPay,Deductions,IncomeTax,EmployeeIdentity) values 
(4000000,1000000,20000,1),
(4500000,200000,4000,2),
(6000000,10000,5000,3),
(9000000,399994,6784,4)

--Update Derived attribute values 
update PayrollCalculate
set TaxablePay=BasicPay-Deductions

update PayrollCalculate
set NetPay=TaxablePay-IncomeTax

select * from PayrollCalculate

--Create Department Table
create table Department
(
DepartmentId int identity(1,1) primary key,
DepartName varchar(100)
)
--Insert Values in Department Table
insert into Department values
('Marketing'),
('Sales'),
('Publishing')

select * from Department

--Create table EmployeeDepartment
create table EmployeeDepartment
(
DepartmentIdentity int ,
EmployeeIdentity int,
Foreign key (EmployeeIdentity) references Employee(EmployeeID),
Foreign key (DepartmentIdentity) references Department(DepartmentID)
)

--Insert Values in EmployeeDepartment
insert into EmployeeDepartment values
(3,1),
(2,2),
(1,3),
(3,4)

select * from EmployeeDepartment
