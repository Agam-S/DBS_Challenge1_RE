
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
    StaffID INT CHECK (LEN(StaffID) = 8),
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
    Year INT CHECK (LEN(Year) = 4),
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
    Year INT CHECK (LEN(Year) = 4),
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


INSERT INTO SUBJECT(SubjCode, Description) VALUES
('ICTPRG418', 'Apply SQL to extract & manipulate data'),
('ICTBSB430', 'Create Basic Databases'),
('ICTDBS205', 'Design a Database');

INSERT INTO STUDENT(StudentID, Surname, GivenName, Gender) VALUES
('s12233445', 'Baird', 'Tim', 'M'),
('s23344556', 'Nguyen', 'Anh', 'M'),
('s34455667', 'Hallinan', 'James', 'M'),
('s45455669', 'Singh', 'Agampreet', 'M');

INSERT INTO TEACHER(StaffID, Surname, GivenName) VALUES
(98776655, 'Young', 'Angus'),
(87665544, 'Scott', 'Bon'),
(76554433, 'Slade', 'Chris');

INSERT INTO SUBJECTOFFERING(SubjCode, Year, Semester, Fee, StaffID) VALUES
('ICTPRG418', 2019, 1, 200, 98776655),
('ICTPRG418', 2020, 1, 225, 98776655),
('ICTBSB430', 2020, 1, 200, 87665544),
('ICTBSB430', 2020, 2, 200, 76554433),
('ICTDBS205', 2019, 2, 225, 87665544);

INSERT INTO ENROLLMENT(StudentID, SubjCode, Year, Semester, Grade, DateEnrolled) VALUES
('s12233445', 'ICTPRG418', 2019, 1, 'D', '2/25/2019'),
('s23344556', 'ICTPRG418', 2019, 1, 'P', '2/15/2019'),
('s12233445', 'ICTPRG418', 2020, 1, 'C', '1/30/2020'),
('s23344556', 'ICTPRG418', 2020, 1, 'HD', '2/26/2020'),
('s34455667', 'ICTPRG418', 2020, 1, 'P', '1/28/2020'),
('s12233445', 'ICTBSB430', 2020, 1, 'C', '2/08/2020'),
('s23344556', 'ICTBSB430', 2020, 2, NULL, '6/30/2020'),
('s34455667', 'ICTBSB430', 2020, 2, NULL, '7/03/2020'),
('s23344556', 'ICTDBS205', 2019, 2, 'P', '7/01/2019'),
('s34455667', 'ICTDBS205', 2019, 2, 'N', '7/13/2019'),

('s45455669', 'ICTPRG418', 2020, 1, 'HD', '5/03/2020');

SELECT * from Student;


-- Query 1:
Select S.GivenName, S.Surname, SO.SubjCode, SB.Description, 
SO.Year, SO.Semester, SO.Fee, T.GivenName, T.Surname FROM ENROLLMENT E

LEFT JOIN STUDENT S ON S.StudentID = E.StudentID
INNER JOIN SUBJECTOFFERING SO ON SO.SubjCode = E.SubjCode
INNER JOIN SUBJECT SB ON SO.SubjCode = SB.SubjCode
INNER JOIN TEACHER T ON T.StaffID = SO.StaffID


-- Query 2:
Select Year, Semester, Count(StudentID) as NumOfEnrollemnts from Enrollment
Group By Year, Semester

-- Query 3:
SELECT * from SUBJECTOFFERING E
WHERE (E.Fee =
(SELECT MAX(E.Fee) 
    FROM SUBJECTOFFERING E
)
)

-- Task 5
CREATE VIEW [DBS_VIEW1] AS
Select S.GivenName, S.Surname, SO.SubjCode, SB.Description, SO.Year, SO.Semester, SO.Fee, T.GivenName, T.Surname FROM ENROLLMENT E
LEFT JOIN STUDENT S ON S.StudentID = E.StudentID
INNER JOIN SUBJECTOFFERING SO ON SO.SubjCode = E.SubjCode
INNER JOIN SUBJECT SB ON SO.SubjCode = SB.SubjCode
INNER JOIN TEACHER T ON T.StaffID = SO.StaffID;


--Task 6
SELECT * FROM Student
--From this- I got the results I should - all the colunms from STUDENT
SELECT COUNT(*) FROM Student
--From this- I got the results I should - all the 4 colunms as a count from STUDENT

/* Task 6- 
I know they are working because I am getting the correct responses as I should and it is working fine,
My code only matched the Query 2 with tables, so it works and that only means I've done Task 6 */