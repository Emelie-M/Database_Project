--Tables
CREATE TABLE Student (
    StudentID INT  IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(30) NOT NULL,
    LastName VARCHAR(30) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Year VARCHAR(10), 
);

CREATE TABLE Organizer (
    OrganizerID INT  IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(30) NOT NULL,
    LastName VARCHAR(30) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
);

CREATE TABLE Event (
    EventID INT  IDENTITY(1,1) PRIMARY KEY,
	OrganizerID int NOT NULL,
    Title VARCHAR(30) NOT NULL,
    Date date,
    Location VARCHAR(100) NOT NULL,
    Capacity int CHECK (Capacity < 300),
	FOREIGN KEY (OrganizerID) REFERENCES Organizer(OrganizerID)
);

CREATE TABLE Registration (
    RegistrationID INT  IDENTITY(1,1) PRIMARY KEY,
	StudentID int NOT NULL,
	EventID int NOT NULL,
    Status VARCHAR(15),
    TimeStamp date,
	FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
	FOREIGN KEY (EventID) REFERENCES Event(EventID),
    CONSTRAINT UQ_Registration UNIQUE (StudentID, EventID)
);


-- INSERT VALUES

-- STUDENT

INSERT INTO Student (FirstName, LastName, Email, Year) VALUES
('Emma', 'Johnson', 'emma.johnson@college.edu', 'Year 1'),
('Liam', 'Brown', 'liam.brown@college.edu', 'Year 2'),
('Sophia', 'Davis', 'sophia.davis@college.edu', 'Year 3'),
('Noah', 'Miller', 'noah.miller@college.edu', 'Year 4'),
('Olivia', 'Wilson', 'olivia.wilson@college.edu', 'Year 2');

--ORGANIZER

INSERT INTO Organizer (FirstName, LastName, Email, Phone) VALUES
('Sarah', 'Anderson', 'sarah.anderson@college.edu', '555-234-5678'),
('James', 'Taylor', 'james.taylor@college.edu', '555-876-5432'),
('Michael', 'Clark', 'michael.clark@college.edu', '555-345-6789');

--EVENT

INSERT INTO Event (OrganizerID, Title, Date, Location, Capacity) VALUES
(1, 'Career Fair 2025', '2025-11-20', 'Student Center Hall A', 150),
(2, 'Science Symposium', '2025-12-05', 'Engineering Auditorium', 120),
(3, 'Cultural Fest', '2025-12-10', 'Campus Grounds', 250),
(1, 'Hackathon 2025', '2025-12-15', 'Tech Lab 1', 80),
(3, 'Volunteer Meetup', '2025-11-30', 'Community Hall', 100);

--REGISTRATION

INSERT INTO Registration (StudentID, EventID, Status, TimeStamp) VALUES
(1, 1, 'Registered', '2025-10-25'),
(1, 4, 'Registered', '2025-10-25'),
(2, 2, 'Registered', '2025-10-25'),
(2, 3, 'Waitlisted', '2025-10-25'),
(3, 1, 'Registered', '2025-10-25'),
(4, 5, 'Cancelled', '2025-10-25'),
(5, 3, 'Registered', '2025-10-25'),
(5, 1, 'Registered', '2025-10-25');


/*
NORMALIZATION

First Normal Form (1NF)

Rule:
All attributes must be atomic (no repeating groups or multi-valued fields).

Application:

Each student has single values for FirstName, LastName, Email, and Year (no combined “Name” field).

Each event stores one Title, Date, Location, and Capacity only — no lists of locations or organizers.

The Registration table records one student–event pair per row.

All attributes hold atomic values → Tables are in 1NF.

Second Normal Form (2NF)

Rule:
Every non-key attribute must depend on the whole primary key (no partial dependency).

Application:

Student, Organizer, and Event tables each have a single-attribute primary key, so 2NF automatically holds.

In Registration, the unique constraint (StudentID, EventID) represents the logical key; non-key fields Status and TimeStamp depend on both StudentID and EventID (the full key).

No partial dependencies → Tables are in 2NF.

Third Normal Form (3NF)

Rule:
There must be no transitive dependency (non-key attributes shouldn’t depend on other non-key attributes).

Application:

Student: Email and Year depend only on StudentID.

Organizer: Phone and Email depend only on OrganizerID.

Event: OrganizerID is a foreign key, but other attributes (Title, Date, Location, Capacity) depend directly on EventID.

Registration: Status and TimeStamp depend on RegistrationID only.

No transitive dependencies → Tables are in 3NF.

Final Normalized Design Summary

Table	          PK	         FKs	                                   Description / Dependencies
Student	        StudentID	        —	                                   Uniquely identifies each student; all fields atomic
Organizer	    OrganizerID	        —	                                   Uniquely identifies each organizer
Event	        EventID	        OrganizerID	                               Each event managed by one organizer
Registration	RegistrationID	StudentID → Student, EventID → Event	   Links students and events; ensures unique pairs

All four tables are in Third Normal Form (3NF).
They eliminate redundancy, maintain referential integrity, and support the required event registration relationships.