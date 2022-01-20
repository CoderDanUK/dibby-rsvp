CREATE DATABASE rsvp;

\c rsvp;

CREATE SCHEMA rsvp;

CREATE TABLE rspv.Invitee (
    Id UUID NOT NULL,
    FirstName VARCHAR(50) NOT NULL, 
    LastName VARCHAR(50) NOT NULL, 
    Email VARCHAR(255), 
    Address VARCHAR(255),
    ParentId UUID,
    CreatedDateTime TIMESTAMP NOT NULL,
    PRIMARY KEY (Id),
    CONSTRAINT FK_ParentInvitee
        FOREIGN KEY (ParentId)
            REFERENCES Invitee(Id)
);

CREATE TABLE rspv.Response (
    Id UUID NOT NULL, 
    InviteeId UUID NOT NULL,
    Attending BIT NOT NULL, 
    Message VARCHAR(1000),
    PRIMARY KEY (Id),
    CONSTRAINT FK_Invitee
        FOREIGN KEY (InviteeId)
            REFERENCES Invitee(Id),
    
);

CREATE TABLE rspv.MealType (
    Id INT NOT NULL,
    Description VARCHAR(255) NOT NULL,
    PRIMARY KEY (Id)
);

INSERT INTO rspv.MealType 
    (Id, Description) VALUES
    (1, 'Starter'),
    (2, 'Main'), 
    (3, 'Desert');

CREATE TABLE rspv.MealOption (
    Id UUID NOT NULL, 
    MealTypeId INT NOT NULL,
    PRIMARY KEY (Id),
    CONSTRAINT 
        FOREIGN KEY (MealTypeId) 
            REFERENCES MealType(Id)
);

CREATE TABLE rspv.MealChoice (
    Id UUID,
    InviteeId UUID,
    MealOptionId UUID,
    PRIMARY KEY (Id)
);

CREATE USER rsvp_readwrite WITH ENCRYPTED PASSWORD 'changeme';

GRANT CONNECT ON DATABASE rsvp TO rsvp_readwrite;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA rsvp TO rsvp_readwrite;