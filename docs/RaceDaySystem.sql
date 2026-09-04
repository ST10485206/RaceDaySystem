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
CREATE TABLE Participants
(
    ParticipantID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    Password NVARCHAR(100) NOT NULL
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
INSERT INTO Event
    (EventName, Location, [Date], OrganiserID)
VALUES
    ('Pretoria City Run', 'Pretoria', '2026-10-10', 1),
    ('Johannesburg Marathon', 'Johannesburg', '2026-11-15', 2),
    ('Tshwane Fun Run', 'Tshwane', '2026-12-05', 1);
GO
INSERT INTO Category
    (CategoryName, EventID)
VALUES
    ('5 KM Run', 1),
    ('10 KM Run', 1),
    ('21 KM Half Marathon', 1),

    ('5 KM Run', 2),
    ('10 KM Run', 2),
    ('42 KM Marathon', 2),

    ('5 KM Fun Run', 3),
    ('10 KM Run', 3),
    ('Family Run', 3);
GO
INSERT INTO EventEnrollment
    (ParticipantID, EventID, EnrollmentDate)
VALUES
    (1, 1, '2026-09-01'),
    (2, 1, '2026-09-02'),
    (1, 2, '2026-09-03'),
    (2, 3, '2026-09-04');
GO
INSERT INTO Results
    (ParticipantID, EventID, Position, FinishTime)
VALUES
    (1, 1, 1, '00:28:35'),
    (2, 1, 2, '00:31:20'),
    (1, 2, 3, '01:45:10');
GO
-- Verify Organiser table
SELECT * FROM Organiser;
GO

-- Verify Event table
SELECT * FROM Event;
GO

-- Verify Category table
SELECT * FROM Category;
GO

-- Verify Participants table
SELECT * FROM Participants;
GO

-- Verify EventEnrollment table
SELECT * FROM EventEnrollment;
GO

-- Verify Results table
SELECT * FROM Results;
GO
SELECT
    Event.EventName,
    Event.Location,
    Event.[Date],
    Organiser.FirstName,
    Organiser.LastName
FROM Event
INNER JOIN Organiser
    ON Event.OrganiserID = Organiser.OrganiserID;
GO
SELECT
    Participants.FirstName,
    Participants.LastName,
    Event.EventName,
    EventEnrollment.EnrollmentDate
FROM EventEnrollment
INNER JOIN Participants
    ON EventEnrollment.ParticipantID = Participants.ParticipantID
INNER JOIN Event
    ON EventEnrollment.EventID = Event.EventID;
GO
SELECT
    Event.EventName,
    Category.CategoryName
FROM Category
INNER JOIN Event
    ON Category.EventID = Event.EventID
ORDER BY Event.EventName;
GO
SELECT
    Participants.FirstName,
    Participants.LastName,
    Event.EventName,
    Results.Position,
    Results.FinishTime
FROM Results
INNER JOIN Participants
    ON Results.ParticipantID = Participants.ParticipantID
INNER JOIN Event
    ON Results.EventID = Event.EventID
ORDER BY Results.Position;
GO