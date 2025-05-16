Create Database Airlines;

use Airlines;


-- Creating the tables

CREATE TABLE  Aircraft (
	Id int primary key identity(1,1),
	Capacity int not null check (Capacity >= 4 AND Capacity <= 500 ),
	Model varchar(50),
	Maj_pilot Varchar (50) not null,
	Assistant Varchar (50),
	Host1 varchar (50),
	Host2 varchar(50),
	AL_id int
);



Create table Airline(
	Id int primary key identity(1,1),
	Name varchar(50) not null,
	Address Varchar(200),
	Cont_person Varchar(300), -- it can be number or email or anything

);


Create table Airline_Phones(
	AL_id int,
	Phone varchar(20),
	primary key (AL_id , Phone)
);


Create table [Transaction](
	Id int primary key identity (1,1),
	Description varchar (200),
	Amount decimal (12,2) not null,
	Date DATE,
	AL_id int
);


Create table Employee (
	Id int primary key identity (1,1),
	Name varchar(50) not null,
	Address Varchar (100),
	Gender Char(1) check(Gender in ('F', 'M')),
	Position Varchar(50),
	BD_Year int,
	BD_Month int check (BD_Month >= 1 AND BD_Month <=12),
	BD_Day int check (BD_Day >= 1 ANd BD_Day <= 31),
	AL_id int
);


Create table Emp_Qualifications (
	Emp_id int,
	Qualifications Varchar(100),
	Primary Key (Emp_id, Qualifications)

);


Create table Route(
	Id int primary key identity(1,1),
	Distance decimal (20,2) check (Distance > 0 ),
	Destination varchar (50) not null,
	Origin varchar (50) not null,
	Classification varchar (50)
)


Create table Aircraft_Routes (
	AC_id int,
	Route_id int,
	Departure varchar (50) not null,
	Num_of_Pass int check (Num_of_Pass >=0), -- Cause sometimes the pilot travling alone to do some repairs 
	Price decimal(10,2) check (Price >= 0 ), -- may be a free flight
	Arrival Datetime,
	Primary key (AC_id , Route_id)
);


-- Adding the fK constraints


Alter table Aircraft
Add constraint FK_Aircraft_Airline
Foreign key (AL_id) references Airline(Id)


Alter table Airline_Phones
Add constraint FK_Airline_Phones_Airline
foreign key (AL_id) references Airline(Id)


Alter table [Transaction]
Add constraint FK_Transaction_Airline
foreign key (AL_id) references Airline(Id)

Alter table Employee
Add constraint FK_Employee_Airline
foreign key (AL_id) references Airline(Id)

Alter table Emp_Qualifications
Add constraint FK_Emp_Qualifications_Employee
foreign key (Emp_id) references Employee(Id)

Alter table Aircraft_Routes
Add constraint FK_Aircraft_Routes_Route
foreign key (Route_id) references Route(Id)


Alter table Aircraft_Routes
Add constraint FK_Aircraft_Routes_Aircraft
foreign key (AC_id) references Aircraft(Id)


