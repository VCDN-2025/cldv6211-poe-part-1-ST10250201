CREATE TABLE dbo.Venues
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Location NVARCHAR(200) NOT NULL,
    Capacity INT NOT NULL,
    ImageUrl NVARCHAR(500) NOT NULL
);
GO

-- Create the Events table with a foreign key referencing Venues
IF OBJECT_ID('dbo.Events', 'U') IS NOT NULL
    DROP TABLE dbo.Events;
GO

CREATE TABLE dbo.Events
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NOT NULL,
    ImageUrl NVARCHAR(500) NOT NULL,
    VenueId INT NOT NULL,
    CONSTRAINT FK_Events_Venues FOREIGN KEY (VenueId)
        REFERENCES dbo.Venues(Id)
        ON DELETE CASCADE  -- Adjust ON DELETE behavior as needed
);
GO

-- Create the Bookings table with a foreign key referencing Events
IF OBJECT_ID('dbo.Bookings', 'U') IS NOT NULL
  DROP TABLE dbo.Bookings;
GO

CREATE TABLE dbo.Bookings
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    EventId INT NOT NULL,
    BookingReference NVARCHAR(100) NOT NULL,
    CONSTRAINT FK_Bookings_Events FOREIGN KEY (EventId)
        REFERENCES dbo.Events(Id)
        ON DELETE CASCADE  -- Adjust ON DELETE behavior as needed
);
GO

-- Optionally, add a unique constraint on BookingReference if required
ALTER TABLE dbo.Bookings
ADD CONSTRAINT UQ_Bookings_BookingReference UNIQUE (BookingReference);
GO