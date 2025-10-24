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
	OrganizerID int,
    Title VARCHAR(30) NOT NULL,
    Date date,
    Location VARCHAR(100) NOT NULL,
    Capacity int CHECK (Capacity < 300),
	FOREIGN KEY (OrganizerID) REFERENCES Organizer(OrganizerID)
);

CREATE TABLE Registration (
    RegistrationID INT  IDENTITY(1,1) PRIMARY KEY,
	StudentID int,
	EventID int,
    Status VARCHAR(15),
    TimeStamp date,
	FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
	FOREIGN KEY (EventID) REFERENCES Event(EventID)
);



--Values
INSERT INTO Student (FirstName, LastName, Email, Year) VALUES
('Kusuo','Saiki','saiki.k@gmail.com','Year 1');

INSERT INTO Organizer (FirstName, LastName, Email, Phone) VALUES
('','','','');

INSERT INTO Event (Title, Date, Location, Capacity) VALUES
('','','','');

INSERT INTO Registration (Status, TimeStamp) VALUES
('','');