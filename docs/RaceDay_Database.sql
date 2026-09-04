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
