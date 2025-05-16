create database iti;

USe iti;


-- Creating the tables in the database
CREATE TABLE Students(
	Id int primary key identity (1,1),
	Fname varchar(50),
	Lname varchar(50) not null,
	Age int check (Age >= 15 AND Age <= 50 ),
	Address varchar(200),
	Dep_id int
);

CREATE TABLE Departments(
	Id int primary key identity(1,1),
	Name varchar(50) not null,
	Hiring_Date date,
	Ins_id int
);

CREATE TABLE Instrcutors(
	ID int primary key identity(1,1),
	Name varchar(50) not null,
	Address varchar(50),
	Bouns decimal(10,2),
	Salary decimal (10,2) not null,
	Hour_rate decimal(10,2),
	Dep_id int
) ;

CREATE TABLE Courses (
	Id int primary key identity(1,1),
	Name varchar(50) not null,
	Duration int check( Duration > 0 ), -- days 
	Description varchar(300),
	Top_id int

);

CREATE TABLE Topic(
	Id int primary key identity(1,1),
	Name Varchar(50) not null
);


CREATE TABLE Stud_Course(
	Stud_id int,
	Course_id int,
	Grade decimal(5,2) check( Grade>= 0 AND Grade <= 100),
	Primary Key (Stud_id, Course_id)
);

CREATE TABLE Course_Instructor (
	Course_id int,
	Inst_id int,
	Evaluation decimal(5,2) check( Evaluation >=0 AND Evaluation <= 100 )
	Primary Key (Course_id , Inst_id)
);


-- ADD FK constraitns 

Alter table Departments 
Add constraint FK_instrcutor_Departments 
Foreign key( Ins_id ) references Instrcutors(Id)


Alter table Students
Add constraint FK_Departments_Students
Foreign key (Dep_id) references Departments(Id)


Alter table Instrcutors
Add constraint FK_Departments_Instructors
Foreign key (Dep_id) references Departments(Id)


Alter table Courses
Add constraint FK_Courses_Topic
foreign key (Top_id) references Topic(Id)

Alter table Stud_Course
Add constraint FK_Student_Stud_Course
Foreign key (Stud_id) references Students(Id)

Alter table Stud_Course
Add constraint FK_Courses_Stud_Course
Foreign key (Course_id) references Courses(Id)

Alter table Course_Instructor
Add constraint FK_Courses_Course_Instructor
Foreign key (Course_id) references Courses(Id)


Alter table Course_Instructor
Add constraint FK_Instructors_Course_Instructor
Foreign key (Inst_id) references Instrcutors(Id)

