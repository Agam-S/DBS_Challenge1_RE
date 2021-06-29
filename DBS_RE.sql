
/* Name : Agampreet Singh
   Student ID : 103615452 */


/* Task 1 | Rational Schema :

SUBJECT(SubjCode, Description)
Primary Key (SubjCode)

TEACHER(StaffID, Surname, GivenName)
Primary Key (StaffID)

STUDENT(StudentID, Surname, GivenName, Gender)
Primary Key (StudentID)

SUBJECTOFFERING(SubjCode, Year, Semester, Fee, StaffID)
Primary Key (SubjCode, Year, Semester)
Foreign Key (SubjCode) REFERENCES SUBJECT
Foreign Key (StaffID) REFERENCES TEACHER

ENROLLMENT(SubjCode, Year, Semester, StudentID, DateEnrolled, Grade)
Primary Key (SubjCode, Year, Semester, StudentID)
Foreign Key (SubjCode, Year, Semester) REFERENCES SUBJECTOFFERING
Foreign Key (StudentID) REFERENCES STUDENT */



/* Task 2 - DB creation */

IF OBJECT_ID('SUBJECT') IS NOT NULL
	DROP TABLE SUBJECT;
GO

CREATE TABLE SUBJECT(

    SubjCode NVARCHAR(100),
    Description NVARCHAR(500),

    PRIMARY KEY (SubjCode)
);

IF OBJECT_ID('TEACHER') IS NOT NULL
	DROP TABLE TEACHER;
GO

CREATE TABLE TEACHER(
    StaffID INT CHECK (StaffID = 8),
    Surname NVARCHAR(100) NOT NULL,
    GivenName NVARCHAR(100) NOT NULL,

    PRIMARY KEY (StaffID)
);

IF OBJECT_ID('STUDENT') IS NOT NULL
	DROP TABLE STUDENT;
GO

CREATE TABLE STUDENT(
    StudentID NVARCHAR(10),
    Surname NVARCHAR(100) NOT NULL,
    GivenName NVARCHAR(100) NOT NULL,
    Gender NVARCHAR(1),
    CONSTRAINT CHK_Student CHECK (Gender IN ('M', 'F', 'I')),

    PRIMARY KEY (StudentID)
);

IF OBJECT_ID('SUBJECTOFFERING') IS NOT NULL
	DROP TABLE SUBJECTOFFERING;
GO

CREATE TABLE SUBJECTOFFERING(
    SubjCode NVARCHAR(100),
    Year INT CHECK (Year = 4),
    Semester INT,
    CONSTRAINT CHK_Semester CHECK (Semester IN (1, 2)),
    Fee MONEY NOT NULL CHECK(Fee > 0),
    StaffID INT,

    PRIMARY KEY (SubjCode, Year, Semester),
    Foreign Key (StaffID) REFERENCES TEACHER,
    Foreign Key (SubjCode) REFERENCES SUBJECT
);

IF OBJECT_ID('ENROLLMENT') IS NOT NULL
	DROP TABLE ENROLLMENT;
GO

CREATE TABLE ENROLLMENT(
    StudentID NVARCHAR(10),
    SubjCode NVARCHAR(100),
    Year INT CHECK (Year = 4),
    Semester INT,
    CONSTRAINT CHK_Semester_Enrollment CHECK (Semester IN (1, 2)),
    Grade NVARCHAR(2),
    CONSTRAINT CHK_Grade CHECK (Grade IN ('N', 'P', 'C', 'D', 'HD')),
    DateEnrolled DATE,

    Primary Key (SubjCode, Year, Semester, StudentID),
    Foreign Key (SubjCode, Year, Semester) REFERENCES SUBJECTOFFERING,
    Foreign Key (StudentID) REFERENCES STUDENT
);



select table_name from information_schema.tables;
exec sp_columns project;