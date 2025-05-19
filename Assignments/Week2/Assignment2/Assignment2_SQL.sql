


------------------------- Part 01 -------------------------

use MyCompany

-- Display all the employees Data ---
SELECT * FROM Employee


-- Display the employee First name, last name, Salary and Department number. -- 
SELECT Fname, Lname, Salary, Dno FROM Employee


-- Display all the projects names, locations and the department which is responsible for it. -- 
SELECT Pname,Plocation, Dnum FROM Project


-- Display each employee full name and his annual commission in an ANNUAL COMM column (alias) with 10 perecnt of his salary.
SELECT Fname + ' ' + Lname AS [Full Name], Salary * 0.10 AS [ANNUAL COMM]
FROM Employee 


-- Display the employees Id, name who earns more than 1000 LE monthly
SELECT SSN, Fname + ' ' + Lname AS [Full Name]
FROM Employee where Salary > 1000


-- Display the employees Id, name who earns more than 10000 LE annually.
SELECT SSN, Fname + ' ' + Lname AS [Full Name]
FROM Employee where Salary * 12 > 10000

-- Display the names and salaries of the female employees 
SELECT Fname + ' '+ Lname AS [Full Name], Salary
FROM Employee where Sex = 'F'

-- Display each department id, name which is managed by a manager with id equals 968574
SELECT	Dnum, Dname
FROM Departments WHERE MGRSSN = 968574

-- Display the ids, names and locations of  the projects which are controlled with department 10.

SELECT Pnumber, Pname, Plocation
FROM Project WHERE Dnum = 10


-- ======================================================================================================================================


------------------------- Part 02 -------------------------


USE ITI

-- Get all instructors Names without repetition.
SELECT distinct ins_Name FROM Instructor -- the talbe dosen't have any reptitive names


-- Display instructor Name and Department Name Note: display all the instructors if they are attached to a department or not.
SELECT ins.Ins_Name AS [Instructor Name],  dep.Dept_Name AS [Department Name]
FROM Instructor AS ins left outer join Department  AS dep
ON ins.Dept_Id = dep.Dept_Id

-- Display student full name and the name of the course he is taking for only courses which have a grade.
SELECT std.St_Fname + ' ' + std.St_Lname AS [Student Full Name], crs.Crs_Name AS [Course Name]
FROM Student AS std, Course AS crs, Stud_Course AS std_crs
where std.st_id = std_crs.St_Id AND crs.Crs_Id = std_crs.Crs_Id

-- Select Student first name and the data of his supervisor.
SELECT std.St_Fname AS [Student Name], super.St_Fname+ ' ' + super.St_Lname AS [Supervisor Full Name], 
super.St_Address AS [Supervisor Address],  super.St_Age AS [Supervisor Age]
FROM Student AS std, Student AS super
where std.st_super = super.St_Id

-- Display student with the following Format.
SELECT std.St_Id AS [Student ID ], std.St_Fname AS [Student Full Name],
dep.Dept_Name AS [Department Name]  
FROM Student AS std, Department AS dep 
where std.Dept_Id = dep.Dept_Id
/*
if we didn't write the join condition we will have Cartesian product (cross join)

SELECT std.St_Id, std.St_Fname+ ' ' + std.St_Lname AS [Student Full Name],
dep.Dept_Name AS [Department Name]  
FROM Student AS std, Department AS dep 

*/

select @@VERSION
select @@SERVERNAME

/*
@@ --> this indicats a golable system variables in SQL server they are read-only we can't modify them 
also it stores server level and session level settings
*/



------------------------- Part 03 -------------------------

USE MyCompany

-- Display the Department id, name and id and the name of its manager.
SELECT dep.Dname AS [Department Name], dep.Dnum AS [Department ID],
emp.SSN AS [Manager ID], emp.Fname +' ' + emp.Lname AS [Manger Full Name]
FROM Departments AS dep, Employee AS emp
where emp.SSN = dep.MGRSSN


-- Display the name of the departments and the name of the projects under its control.
SELECT dep.Dname As [Department Name], p.Pname AS [Project Name]
FROM Departments AS dep, Project AS p
WHERE dep.Dnum = p.Dnum


--  Display the full data about all the dependence associated with the name of the employee they depend on
SELECT emp.Fname+ ' '+ emp.Lname AS [Employee Full Name], 
d.Dependent_name AS [Dependent Name], d.Sex AS [Dependent Gender], d.Bdate AS [Dependant Bdate] 
FROM Dependent AS d, Employee AS emp 
WHERE d.ESSN = emp.SSN

-- Display the Id, name, and location of the projects in Cairo or Alex city.
SELECT Pnumber, Pname, Plocation
FROM Project wHERE City = 'Cairo' or City = 'Alex'
 

-- Display the Projects full data of the projects with a name starting with "a" letter.
SELECT * FROM Project
WHERE Pname like 'a%'


-- display all the employees in department 30 whose salary from 1000 to 2000 LE monthly
SELECT * FROM Employee
WHERE Salary >= 1000 AND Salary <= 2000

-- Retrieve the names of all employees in department 10 who work more than or equal 10 hours per week on the "AL Rabwah" project.
SELECT Fname +' '+ Lname AS [Employee Full Name]
FROM Employee AS emp, Project AS p, Works_for as emp_proj
where emp.SSN = emp_proj.ESSn AND p.Pnumber = emp_proj.Pno AND emp.Dno = 10 AND  emp_proj.Hours >= 10 AND p.Pname = 'AL Rabwah'

-- Find the names of the employees who were directly supervised by Kamel Mohamed

-- using inner join
SELECT emp.Fname +' '+ emp.Lname AS [Employee Full Name]
FROM Employee AS emp inner join Employee AS super 
on emp.Superssn = super.SSN where super.Fname = 'Kamel' ANd super.Lname = 'Mohamed'
/*
Using subqueries
SELECT emp.Fname +' '+ emp.Lname AS [Employee Full Name]
FROM Employee AS emp, Employee AS super 
where emp.Superssn = super.SSN AND super.SSN in (SELECT SSN  FROM Employee where Fname = 'Kamel' AND Lname = 'Mohamed' )
*/

-- Display All Data of the managers
SELECT distinct super.Fname +' '+ super.Lname AS [Manager Full Name], super.Bdate AS [Manger Bdate], super.Address, super.Sex, super.Salary
FROM Employee AS emp, Employee AS super	
where emp.Superssn = super.SSN

/* using subqueires  
SELECT Fname +' '+ Lname AS [Manager Full Name], Bdate AS [Manger Bdate], Address, Sex, Salary
from Employee where Employee.SSN in ( select Superssn from Employee where Superssn is not null )
*/

-- Retrieve the names of all employees and the names of the projects they are working on, sorted by the project name.
SELECT emp.Fname +' '+ emp.Lname AS [Employee Full Name], p.Pname AS [Project Name]
FROM Employee AS emp, Project as p, Works_for as emp_pro
where emp.SSN = emp_pro.ESSn AND p.Pnumber = emp_pro.Pno
order by [Project Name] ASC


-- For each project located in Cairo City, find the project number, the controlling department name, the department manager’s last name, address and birthdate.

SELECT p.Pnumber, dep.Dname, manager.Lname AS [Manager Last Name], manager.Address AS [Manager Address], manager.Bdate AS [Manager Bdate]
FROM Project AS p, Departments AS dep, Employee AS manager
WHERE p.City = 'Cairo' AND p.Dnum = dep.Dnum AND dep.MGRSSN = manager.SSN
 

-- Display All Employees data and the data of their dependents even if they have no dependents.
SELECT *FROM Employee AS emp left outer join Dependent AS d
on d.ESSN = emp.SSN


------------------------- Part 04 -------------------------


------------- DQL ------------- 
-- Retrieve a list of employees and the projects they are working on ordered by department and within each department, ordered alphabetically by last name, first name.
SELECT emp.Fname + ' ' +emp.Lname AS [ Employee Full Name], dep.Dname, pro.Pname
FROM Employee AS emp, Departments AS dep, Project AS pro, Works_for AS emp_pro
where emp.SSN = emp_pro.ESSn AND pro.Pnumber = emp_pro.Pno AND emp.Dno = dep.Dnum
order by dep.Dname ASC, emp.Lname ASC, emp.Fname ASC


-- Try to update all salaries of employees who work in Project ‘Al Rabwah’ by 30% 	

SELECT emp.Fname + ' ' +emp.Lname AS [ Employee Full Name], emp.Salary AS [Current Salary], emp.Salary * 1.3 As [Updated Salary]
FROm Employee AS emp, Project AS pro, Works_for AS emp_pro
WHERE emp.SSN = emp_pro.ESSn AND pro.Pnumber = emp_pro.Pno AND pro.Pname = 'Al Rabwah'


------------- DML -------------
-- In the department table insert a new department called "DEPT IT”, with id 100, employee with 
-- SSN = 112233 as a manager for this department. The start date for this manager is '1-11-2006'.

Insert into Departments values ('DEPT IT',100, 112233,'2006-11-01' )


--Do what is required if you know that: Mrs. Oha Mohamed (SSN=968574) moved to be the manager
-- of the new department (id = 100), and they give you (your SSN =102672) her position (Dept. 20 manager) 

-- First I will instert a record which will contain my information

Insert into Employee(Fname,Lname,SSN,Bdate,Address,Sex,Salary,Superssn) values ('Abdelrahman','Tarek',102672, '2004-09-03', 'Giza', 'M', 10000, Null )
Select * from Employee where Fname in ('Abdelrahman','Noha' )
select* from Departments where Dnum in  (20, 100)

/*
 Noha --> ssn = 968574, mange dnum 20
 Abdelrahman ssn = 102672
 Noha will mange dnum 100
 need to :
	- make MGRSSN for dnum 100 = 968574 --> departments talbe
	- make Dno = 100 --> Employee table

 Abdo will mange dnum 20
need to:
	- make MGRSSN for dnum 20 = 102672 --> departments talbe
	- make Dno = 20 --> Employee table 


*/
-- department 100
update Departments set MGRSSN =  968574 where dnum = 100
update Employee set Dno = 100 where SSN = 968574

-- Department 20
update Departments set MGRSSN =  102672 where dnum = 20
update Employee set Dno = 20 where SSN = 102672


-- see the resutlts
Select * from Employee where Fname in ('Abdelrahman','Noha' )
select* from Departments where Dnum in  (20, 100)


-- 102660 needs to be inserted to the employee table
Insert into Employee(Fname,Lname,SSN,Bdate,Address,Sex,Salary,Superssn) values ('Ahmed','khaled',102660, '2004-09-03', 'Giza', 'M', 10000, Null )

update Employee set Superssn = 102672 where SSN = 102660
select * from Employee where ssn = 102660


/* Unfortunately, the company ended the contract with Mr. Kamel Mohamed (SSN=223344) 
 so try to delete him from your database in case you know that you will be temporarily in his position.
 Hint: (Check if Mr. Kamel has dependents, works as a department manager, supervises any employees or works in any projects and handles these cases) */

 /*
	to delete Mr. Kamel Mohamed from our database we need to handl some cases:
		- Reassign the departments which were superviesed by him
		- Reassign the employees who were superviesed by him
		- Reassign the projects which he was working on
		- Reassign the depenedents who were related to him
 */

 -- reassign his departments
update Departments set MGRSSN = 102672 , [MGRStart Date] = GETDATE() where MGRSSN = 223344

--  reassign his employees 
select * from Employee where Superssn = 102672
update Employee set Superssn = 102672 where Superssn = 223344
select * from Employee where Superssn = 102672

-- reassign the projects
SELECT P.Pname, W.Hours 
FROM Works_for W JOIN Project P ON W.Pno = P.Pnumber 
WHERE W.Essn = '223344';

Update Works_for set ESSn = 102672 where ESSn = 223344

SELECT P.Pname, W.Hours 
FROM Works_for W JOIN Project P ON W.Pno = P.Pnumber 
WHERE W.Essn = '102672';

-- reassign the dependents 

SELECT * FROM Dependent WHERE Essn = '102672';

update Dependent set  ESSN = 102672 where ESSN = 223344

-- Finally deleting Mr Kamel
Delete from Employee where SSN = 223344
select * from Employee where SSN = 223344 -- --> nothing


