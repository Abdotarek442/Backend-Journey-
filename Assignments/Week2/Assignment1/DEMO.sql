USE ITI

-- Display all data from Course table
SELECT * FROM course	

-- Display all from Ins_Course table
SELECT * FROM Ins_Course

-- Single comment [Ctrl k + Ctrl c]
-- Uncomment [Ctrl k + Ctrl U]


-- Date Types --

-- Numeric --

bit			-- boolean [0,1]
tinyint		-- 1 Byte [-128:127] or [0:255] unsigned
smallint	-- 2 Byte [-32768:32767] or [0:65535] unsigned
int			-- 4 Byte
bigint		-- 8 Byte

--Fractions--

 smallmoney		-- 4 numbers after point [4B.0000]
 money			-- 4 numbers after point [8B.0000]
 real			-- 7 numbers after point
 float			-- 15 numbers after point
 dec
 decimal		-- Make validations (Recommened)
 dec(5,2)		-- (total length of number , Numbers after point )

 -- Strings

 char (10)		-- fixed length character 
 varchar(15)	-- variable length
 nchar(10)		-- fixed length but with unicode
 nvarchar(15)	-- variable length but with unicode Can store Arabic
 nvarchar(max)	-- can store up to 2GB [unicode :can store Arabic]
 varchar(max)	-- can store up to 2GB 

 -- DateTime
Date			-- MM/dd/yyyy [format depends on the server]
Time			-- hh:mm:ss.123 Default -> time(3) up to 3 digits in milsec
Time(5)			-- hh:mm:ss.12345
smalldatetime	-- MM/dd/yyyy hh:mm:00
datetime		-- MM/dd/yyyy hh:mm:ss.123
datetime2(5)	-- MM/dd/yyyy hh:mm:ss.12345
datetimeoffset	-- 11/23/2020 10:30 + 2:00 Timezone

-- Binary

Binary				-- 01010101
VarBinary(max)		-- Variable length binary, store[images, pdfs, files,...]
Image

-- Other Datatypes

Xml				--store xml syntax
sql_variant		--like var in js [int, deciaml, ...]

-- Variables

-- Global variables @@
SELECT @@SERVERNAME

SELECT @@VERSION

SELECT @@LANGUAGE

--Local variables ==> stored in RAM

DEclare @age int = 5 
set @age = 20
select @age

Declare @Number decimal(4,2) = 12.45
select @Number


---------------------  StudyCase DB ---------------

------ DDL create DB
create database CompanyG02

-- select db
USE CompanyG02

-- CREAT TABLES
craete table Employees(

	Id int primary key identity(1,1), --unique and not null
	Fname varchar(15) not null, --required
	Lname varchar(15), --optional
	Gender char(1), --F || M
	Birthdate date ,
	Dnum int , --FK
	Super_Id int references Employees(Id)

);


create table Departments(

Dnum int primary key identity(10,10),
Danme varchar(20) not null,
Manager_Id int references Employees(Id) unique not null,
Hiring_date date not null,

);


create table Department_Locations(

	Dnum int references Departments(Dnum),
	Location varchar(20),
	primary key(Dnum, Location)

);


create table Projects (

	Pnum int primary key identity(1,1),
	Pname varchar(20) not null, --required
	Location varchar(30) default 'Cairo',
	City varchar(30) not null,
	Dnum int references Departments(Dnum)

);

create table Dependents(

	Name varchar(30) not null,
	Birthdate date,
	Gender char(1),
	Emp_Id int references Employees(Id),
	primary key (Name, Emp_Id)

);

create table Emp_Projects(

	Emp_Id int references Employees(Id),
	Pnum int references Projects(Pnum),
	NumOfHours int ,
	primary key (Emp_Id , Pnum)

)
 
-- DDL Alter 

-- Alter DB name

Alter Database CompanyG02
Modify Name = CompanyG02Test

Use CompanyG02Test

-- Alter DB objs
-- Alter add [Add col - add constraint]
-- Alter alter [col datatype]
-- Alter drop [Drop col - Drop constraint]

-- a] ALter add


-- add col
alter table Employees 
add test int

-- add constraint

alter table Employees
add constraint Uq_constraint Unique(test)

--or 

alter table Employees 
add Unique(test)

-- add fk constraint to dnum in employees table
alter table employees 
add constraint Fk_constraint foreign key(Dnum) references Departments (Dnum)

--or will generate FK id automatically
alter table employees 
add foreign key(Dnum) references Departments (Dnum)

-- b] Alter alter 
-- change datatype of col

alter table employees
alter column test tinyint -- you should delete unique constraint first

-- c] Alter drop

--Drop Col test
alter table employees 
drop column test  -- you should delete constraint first

-- Drop constraint 
alter table employees 
drop constraint Uq_Constarint


------- DDL Drop

--Drop DB ---
 Drop database CompanyG02Test

--Drop table
Drop table Employees
