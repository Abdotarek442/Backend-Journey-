-- we only use the sub query if we had to and there were no other solution 


use ITI

select * from student


select AVG(st_Age) from student

select st_Fname, st_age 
from student where 
st_age > 26


--- if we new the avarage and we started to compare the avg with our resutl --> if we added any values and the avg wiill be changed so it will not be efficintt
SELECT st_fname, st_Age 
FROM Student
WHERE st_Age > (SELECT AVG ( st_Age) FROM student) -- this is subquery to handel the above problem


SELECT st_Id , Count(*)
FROM student



select st_Id, count(*) over (partition by st_id)
from student


SELECT count(*) from student  -- 19


 -- assumnig that 19 is the number of students in the table 

select st_Id, 19 'count' 
from student


select st_Id,( select count (*) from student ) 'count' 
from student



-- get departments names that has sudents [Join - subquery ]

select d.dept_Name
from student S,  Department D
where d.Dept_Id = s.Dept_Id



select D.dept_Name
from Department D
where D.Dept_Id in (10,20,30,40) -- we are not sure that this data is fixed, we need to make our queries to be as dynamic as possabile


select d.Dept_Name
from department D
where d.Dept_Id in ( select distinct Dept_Id
from Student
where Dept_Id is not null ) -- now we make it dynamic if we added any other student in different departments it will be here 

-- subquery with dml
----------------------------------- subquery with delete 
--- delete students grades who are living in mansoura




select s.St_Id , s.St_Fname, sc.Grade
from Student s, Stud_Course sc
where s.St_Id = sc.St_Id and St_Address = 'Cairo'


delete 
from Stud_Course 
where St_Id in (select s.St_Id , s.St_Fname, sc.Grade
from Student s, Stud_Course sc
where s.St_Id = sc.St_Id and St_Address = 'Cairo')



-- top --> it is not a function it is just a keyword 
-- top --> limits the rows returned in query resutl set to a specified number number of rows or percentage of row
-- top (expression) [with ties]
-- [] --> it means it is optional to be excuted
-- top (expression) [percent] [with ties]

/*

with variable
declare @Num int = 5 
select top (@Num) precent  from topic
*/

-- select all info from first 2 sudents

select top (2)*
from Student


-- select f_name, l_name from first 4 students


select top(4) st_Fname, st_Lname
from student

-- select last 5 students 
-- this is a walkaround we need to sort the table in desciding order and after that we will excute top

select top(5) St_Id st_Fname, st_Lname
from student
order by st_id desc

-- select the instrcutor with the max salary

select MAX(Salary)
from Instructor

-- we need to sort the table based on the salary in desc order and after that we will excute top

select top (1)*
from Instructor
order by Salary desc



-- select the instrcutor with the min salary
select * from Instructor
select top (1)*
from Instructor
order by Salary asc

-- select the instrcutor with second max salary
-- without using top [max value]


select max(salary)
from Instructor

select max(salary)
from Instructor
where salary != (select max (salary) from Instructor )

select top 1 *
from 
( select top 2  ins_name,salary
from Instructor
order by salary desc ) as subquery 


-- select 25% of talbe student

select top (25) percent *
from student

select * from Student


-- select with top using variable

declare @Num int = 10 -- this is for better use for the top if we wanted to modify the variable

select top (@Num)*
from Student 


-- Top with ties
-- Note : you must use order by with it

select top (5) with ties* 
from student 
order by st_age desc -- returned 6 rows cause the last row the st_age = 25 equals to the sixth row


-- Random selection

select *
from instructor
order by salary

-- SElECT NEWID() guid
select NEWID()


-- Here every time we will excute the query it will return a different data
select*
from Student
order by NEWID()

-- select a random perecntage [50] of row

select top (25) percent *
from Student
order by NEWID() 
-- why we are using NEWID --> if we want to pick a random amount of data of records from our data 
-- Rather than iterating over the table record by record  we can simply use it to pick the nunmber of records that we want 


-------------------- Ranking Functions ------------------------------
-- Row_Number ()
-- Dense_Rank ()
-- Rank()

-- Exl : Try RN, DR , R with instructor salary desc

select Ins_Name, Salary,
Row_NUmber() over (order by salary desc) [RN],
Dense_rank() over (order by salary desc) [DR],
Rank() over (order by salary desc) [R]
from Instructor

select Ins_Name, Salary, Dept_id,
Row_NUmber() over ( partition by dept_Id order by salary desc) [RN],
Dense_rank() over (partition by dept_Id order by salary desc) [DR],
Rank() over (partition by dept_Id order by salary desc) [R]
from Instructor


--- ex2: get the 2 oldest studetns [Fname, Age ] at student table 

--> using top

select *
from Student
order by st_age desc


select top 2*
from Student
order by st_age desc

--- using ranking

select st_id, St_Fname, st_age,
row_number() over ( order by st_age desc) [RN] -- 3 
from Student -- 1 
where RN in (1,2) --  2
-- this is invalid caause RN isn't knowing for the compiler yet


select * 
from (
select st_id, St_Fname, st_age,
row_number() over ( order by st_age desc) [RN] 
from Student  
) as subquery 
where RN in (1,2)

-- Ex3 : get the 5th younger student [Fname, age]
--> using top  
select * 
from (
select st_id, St_Fname, st_age,
row_number() over ( order by st_age desc) [RN] 
from Student  
) as subquery 
where RN in (1,2)


select Top 1*
from 

(
 select top 5*
 from Student
 where st_age is not null
 order by st_age) as yoyungeststudents
 order by st_age desc

 -- Ex3 : get the 5th younger student [Fname, age]
--> using ranking

select *
from (
select st_id, st_Fname ,st_age,
ROW_NUMBER() over( order by st_age) [RN]
from Student
where st_age is not null
) subquerey
where RN = 5


-- ex4: get the younger student at each department

select * 
from (
select st_Fname, st_age, dept_id,
ROW_NUMBER () over (partition by dept_id order by st_age) [RN]
from Student
where St_Age is not null AND Dept_Id is not null
) subquery
where RN = 1


-- get the instructor have max salary per department for each departmetn

select *
from (
select Ins_Id, Ins_Name, salary, dept_id,
ROW_NUMBER() over( partition by dept_id order by salary desc) [RN]
from Instructor ) as subqeury
where RN = 1 

-- another syntax
WITH subquery as
(select Ins_Id, Ins_Name, salary, dept_id,
ROW_NUMBER() over( partition by dept_id order by salary desc) [RN]
from Instructor ) 

select * from subquery


-- Ntile(int)
--> ranking by groups 
-- Ex1 : ranking instrcutors due to their salary from high to low [3 groups]

select ins_id, ins_name, salary,
NTILE (4) over (order by salary desc )[Ntile]
from Instructor

--Ex2 : Ranking courses due to their course durations [4 groups] 
select Crs_Name, Crs_Duration,
Ntile(4) over (order by Crs_Duration desc) [Ntile]
from Course


-- Ex2 : Ranking course due to their course duration [2 gropus]
-- using partition by topic id

select Crs_Duration, Crs_Name, top_id,
NTILE(2) over(partition by top_id order by crs_duration desc) [Ntile]
from course

-- use ntile for pagination
-- Num of products, count of pages
-- use Northwind

-- get only products at page 1
/*
select * 
from (
select productId, productName,
Ntile(10) over ( order by productid ) [page number]
from prodcuts) as products

where pagenumber = 1
*/

-- partition by categoryid
/*

select productId, productName, CategoryId,
Ntile(4) over (partition by category id order by productid)
from products


offset [skip] / fetch [take]
--> used for pagination 

*/

select *
from Student
order by St_Id
offset 10 rows
fetch next 10 rows only

-- Execution order --> created by the database engine
/*
1- From					 2- join/on
3- where				 4- Group by
5- Having				 6- select
7- Distinct				 8- order by
9- top

*/

-- concat fname and lname [ahmed hassan]
select st_id, concat(st_fname ,' ' , st_Fname) [Full Name]-- 3 
from Student -- 1
where fullName = 'Ahmed hassan' -- 2 
-- invaild


select st_id, concat(st_fname ,' ' , st_Fname) [Full Name]
from Student
where concat(st_fname ,' ' , st_Fname) = 'Ahmed hassan'


select *
from 
(
select st_id, concat(st_fname ,' ' , St_Lname) [Full Name]
from Student
) as subquery 
where [Full Name] = 'Ahmed Hassan'


-- 
