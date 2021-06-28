
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
