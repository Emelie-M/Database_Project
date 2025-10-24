
CREATE TABLE Student (
    StudentID INT  IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(30) NOT NULL,
    LastName VARCHAR(30) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Year VARCHAR(10),
);

CREATE TABLE Registration (
    RegistrationID INT  IDENTITY(1,1) PRIMARY KEY,
    Status VARCHAR(15),
    TimeStamp date,
	StudentID int,
	EventID int,
	FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
	FOREIGN KEY (EventID) REFERENCES Event(EventID)
);

CREATE TABLE Event (
    EventID INT  IDENTITY(1,1) PRIMARY KEY,
    Title VARCHAR(30) NOT NULL,
    Date date,
    Location VARCHAR(100) NOT NULL,
    Capacity int CHECK (Capacity < 300),
	OrganizerID int,
	FOREIGN KEY (OrganizerID) REFERENCES Organizer(OrganizerID)
);

CREATE TABLE Organizer (
    OrganizerID INT  IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(30) NOT NULL,
    LastName VARCHAR(30) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
);