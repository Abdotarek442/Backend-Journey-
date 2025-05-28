
-- Part 01

use ITI


-- Retrieve a number of students who have a value in their age
Select count(*)	[Number of students]
from Student
where St_Age is not null


-- Display number of courses for each topic name 
Select t.Top_Name,  Count(c.Crs_id) [Number of courses]
from Topic t left outer join Course c 
on t.Top_Id = c.Top_Id  
group by t.Top_Name

-- Display student with the following Format (use isNull function)
-- Student ID Student Full Name Department name
select * from Student
select St_Id [Student ID],
ISNULL ( s.St_Fname  + ' ' + s.St_Lname, 'Name not provided' ) AS 'Student Full Name',
ISNULL ( d.Dept_Name, 'No department' ) AS 'Department name'
from Student s, Department d
where s.Dept_Id = d.Dept_Id


-- Select instructor name and his salary but if there is no salary display value ‘0000’ . “use one of Null Function” 
select * from Instructor 
select Ins_Name, 
ISNULL( Salary, '0000') As Salary
from Instructor


-- Select Supervisor first name and the count of students who supervises on them
select * from Student

select Super.St_Fname [Supervisor Name], COUNT(std.St_Id) [Number of Supervised Students] 
from Student Super LEFT OUTER JOIN Student std
ON super.St_Id = std.St_super
group by super.St_Fname

-- Display max and min salary for instructors
select MIN(salary) [Min salary], MAX(Salary) [Max salary]
from Instructor
where Salary is not null

-- Select Average Salary for instructors 
select AVG(Salary) [Average salary]
from Instructor
where salary is not null 


-- Display instructors who have salaries less than the average salary of all instructors.
select Ins_Name, salary
from Instructor
where Salary < ( select AVG(Salary) from Instructor where Salary is not null )


-- Display the Department name that contains the instructor who receives the minimum salary
select * from Instructor

select d.Dept_Name, ins.Ins_Name
from Department d, Instructor ins
where d.Dept_Id = ins.Dept_Id AND ins.Salary = (select min(Salary) from Instructor where Salary is not null)


-- Select max two salaries in the instructor table
select top 2 Salary, Ins_Name
from Instructor
order by Salary desc



------------- part 02
use MyCompany

-- For each project, list the project name and the total hours per week (for all employees) spent on that project.
select * from Works_for
select * from Project
select  p.Pname [Project Name] ,   SUM(work.Hours) [total hours per week]
from Project p left outer join Works_for work
on p.Pnumber = work.pno
group by p.pname

--- For each department, retrieve the department name and the maximum, minimum and average salary of its employees.
select d.Dname [Department Name],
MAX(Salary) [Max salary],
MIN(Salary) [Min salary],
AVG(Salary) [Avg salary]
from Departments d left outer join Employee e
on e.Dno = d.Dnum
where e.Salary is not null
group by d.Dname

