--RaceDaySystem Database Script
--Programming POE Part1 
CREATE DATABASE RaceDay;
GO

USE RaceDay;
GO
CREATE TABLE Organiser
(
    OrganiserID INT IDENTITY(1,1) PRIMARY KEY,
    Firstname VARCHAR(50) NOT NULL,
    Lastname VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Phonenumber VARCHAR(20) NOT NULL
);
GO

CREATE TABLE Event
(
    EventID INT IDENTITY(1,1) PRIMARY KEY,
    EventName NVARCHAR(100) NOT NULL,
    Location NVARCHAR(100) NOT NULL,
    [Date] DATE NOT NULL,
    OrganiserID INT NOT NULL,

    CONSTRAINT FK_Event_Organiser
        FOREIGN KEY (OrganiserID)
        REFERENCES Organiser(OrganiserID)
);
GO

CREATE TABLE Category
(
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL,
    EventID INT NOT NULL,

    CONSTRAINT FK_Category_Event
        FOREIGN KEY (EventID)
        REFERENCES Event(EventID)
);
GO

CREATE TABLE EventEnrollment
(
    EnrollmentID INT IDENTITY(1,1) PRIMARY KEY,
    ParticipantID INT NOT NULL,
    EventID INT NOT NULL,
    EnrollmentDate DATE NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_Enrollment_Participant
        FOREIGN KEY (ParticipantID)
        REFERENCES Participants(ParticipantID),

    CONSTRAINT FK_Enrollment_Event
        FOREIGN KEY (EventID)
        REFERENCES Event(EventID)
);
GO

CREATE TABLE Results
(
    ResultsID INT IDENTITY(1,1) PRIMARY KEY,
    ParticipantID INT NOT NULL,
    EventID INT NOT NULL,
    Position INT NOT NULL,
    FinishTime TIME NOT NULL,

    CONSTRAINT FK_Results_Participant
        FOREIGN KEY (ParticipantID)
        REFERENCES Participants(ParticipantID),

    CONSTRAINT FK_Results_Event
        FOREIGN KEY (EventID)
        REFERENCES Event(EventID)
);
GO
INSERT INTO Organiser
    (FirstName, LastName, Email, Password, PhoneNumber)
VALUES
    ('Thabo', 'Mokoena', 'thabo@raceday.co.za', 'Thabo123', '0712345678'),
    ('Lerato', 'Motshwane', 'lerato@raceday.co.za', 'Lerato123', '0723456789');
GO
INSERT INTO Participants
    (FirstName, LastName, Email, Password)
VALUES
    ('khutso', 'Motshwane', 'khutso@gmail.com', 'khutso123'),
    ('Kagiso', 'Mokefe', 'kagiso@gmail.com', 'Kagiso123');
GO
