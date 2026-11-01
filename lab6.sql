CREATE DATABASE CollegeDB1;
USE CollegeDB1;


CREATE TABLE Department (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50) NOT NULL,
    Location VARCHAR(50)
);

-- 2. Create Student Table

CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50) NOT NULL,
    Age INT,
    Gender VARCHAR(10),
    Marks DECIMAL(5,2),
    DeptID INT,
    Email VARCHAR(100),
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);


CREATE TABLE Course (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(50) NOT NULL,
    Credits INT
);


INSERT INTO Department VALUES
(101, 'Computer Science', 'Block A'),
(102, 'Pharmacy', 'Block B'),
(103, 'Commerce', 'Block C'),
(104, 'Mathematics', 'Block D');


INSERT INTO Student VALUES
(1, 'Amit', 20, 'Male', 85.50, 101, 'amit@gmail.com'),
(2, 'Priya', 21, 'Female', 92.00, 102, 'priya@gmail.com'),
(3, 'Rahul', 19, 'Male', 76.50, 101, 'rahul@gmail.com'),
(4, 'Neha', 22, 'Female', 88.00, 103, 'neha@gmail.com'),
(5, 'Arjun', 20, 'Male', 69.50, 104, 'arjun@gmail.com'),
(6, 'Sneha', 21, 'Female', 95.00, 102, 'sneha@gmail.com'),
(7, 'Rohit', 23, 'Male', 72.00, 103, 'rohit@gmail.com'),
(8, 'Pooja', 20, 'Female', 81.00, 104, 'pooja@gmail.com');

-- 6. Insert Course Data

INSERT INTO Course VALUES
(201, 'Database Management System', 4),
(202, 'Python Programming', 4),
(203, 'Mathematics', 3),
(204, 'Computer Networks', 3),
(205, 'Data Structures', 4);


-- 1. Display All Students

DELIMITER //
CREATE PROCEDURE ShowStudents()
BEGIN
    SELECT * FROM Student;
END //
DELIMITER ;

CALL ShowStudents();


-- 2. Display All Departments

DELIMITER //
CREATE PROCEDURE ShowDepartments()
BEGIN
    SELECT * FROM Department;
END //
DELIMITER ;

CALL ShowDepartments();


-- 3. Display All Courses

DELIMITER //
CREATE PROCEDURE ShowCourses()
BEGIN
    SELECT * FROM Course;
END //
DELIMITER ;

CALL ShowCourses();


-- 4. Display Student by ID

DELIMITER //
CREATE PROCEDURE GetStudent(IN sid INT)
BEGIN
    SELECT * FROM Student
    WHERE StudentID = sid;
END //
DELIMITER ;

CALL GetStudent(3);


-- 5. Display Students from a Department

DELIMITER //
CREATE PROCEDURE GetStudentsByDept(IN did INT)
BEGIN
    SELECT * FROM Student
    WHERE DeptID = did;
END //
DELIMITER ;

CALL GetStudentsByDept(102);


-- 6. Display Students Above Given Marks

DELIMITER //
CREATE PROCEDURE StudentsAboveMarks(IN m DECIMAL(5,2))
BEGIN
    SELECT * FROM Student
    WHERE Marks > m;
END //
DELIMITER ;

CALL StudentsAboveMarks(80);


-- 7. Display Total Number of Students

DELIMITER //
CREATE PROCEDURE TotalStudents()
BEGIN
    SELECT COUNT(*) AS TotalStudents
    FROM Student;
END //
DELIMITER ;

CALL TotalStudents();


-- 8. Check Student Result

DELIMITER //
CREATE PROCEDURE CheckResult(IN sid INT)
BEGIN
    SELECT StudentName, Marks,
    IF(Marks >= 50, 'Pass', 'Fail') AS Result
    FROM Student
    WHERE StudentID = sid;
END //

DELIMITER ;

CALL CheckResult(3);


-- 9. Display Students of a Particular Gender

DELIMITER //

CREATE PROCEDURE GetStudentsByGender(IN g VARCHAR(10))
BEGIN
    SELECT * FROM Student
    WHERE Gender = g;
END //
DELIMITER ;

CALL GetStudentsByGender('Female');


-- 10. Display Students Within a Marks Range

DELIMITER //
CREATE PROCEDURE StudentsBetweenMarks(
    IN m1 DECIMAL(5,2),
    IN m2 DECIMAL(5,2)
)
BEGIN
    SELECT * FROM Student
    WHERE Marks BETWEEN m1 AND m2;
END //
DELIMITER ;

CALL StudentsBetweenMarks(70, 90);


-- STORED FUNCTIONS

-- 11. Add Two Numbers

DELIMITER //
CREATE FUNCTION AddTwoNumbers(a INT, b INT)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN a + b;
END //
DELIMITER ;

SELECT AddTwoNumbers(10, 20);


-- 12. Find Square

DELIMITER //
CREATE FUNCTION FindSquare(n INT)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN n * n;
END //
DELIMITER ;

SELECT FindSquare(5);


-- 13. Check Pass or Fail

DELIMITER //
CREATE FUNCTION ResultStatus(m DECIMAL(5,2))
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    IF m >= 50 THEN
        RETURN 'Pass';
    ELSE
        RETURN 'Fail';
    END IF;
END //
DELIMITER ;

SELECT ResultStatus(75);


-- 14. Find Student Grade

DELIMITER //
CREATE FUNCTION StudentGrade(m DECIMAL(5,2))
RETURNS VARCHAR(2)
DETERMINISTIC
BEGIN
    IF m >= 90 THEN
        RETURN 'A';
    ELSEIF m >= 75 THEN
        RETURN 'B';
    ELSEIF m >= 60 THEN
        RETURN 'C';
    ELSE
        RETURN 'D';
    END IF;
END //
DELIMITER ;
SELECT StudentGrade(85);


-- 15. Find Age Category

DELIMITER //
CREATE FUNCTION AgeCategory(a INT)
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    IF a >= 18 THEN
        RETURN 'Adult';
    ELSE
        RETURN 'Minor';
    END IF;
END //
DELIMITER ;

SELECT AgeCategory(20);


-- 16. Calculate Bonus

DELIMITER //
CREATE FUNCTION CalculateBonus(m DECIMAL(5,2))
RETURNS INT
DETERMINISTIC
BEGIN
    IF m >= 90 THEN
        RETURN 1000;
    ELSEIF m >= 75 THEN
        RETURN 500;
    ELSE
        RETURN 200;
    END IF;
END //
DELIMITER ;

SELECT CalculateBonus(85);


-- 17. Find Higher Number

DELIMITER //
CREATE FUNCTION HigherNumber(a INT, b INT)
RETURNS INT
DETERMINISTIC
BEGIN
    IF a > b THEN
        RETURN a;
    ELSE
        RETURN b;
    END IF;
END //
DELIMITER ;

SELECT HigherNumber(10, 20);


-- 18. Calculate Double Marks

DELIMITER //
CREATE FUNCTION DoubleMarks(m DECIMAL(5,2))
RETURNS DECIMAL(6,2)
DETERMINISTIC
BEGIN
    RETURN m * 2;
END //
DELIMITER ;

SELECT DoubleMarks(40);


-- 19. Calculate Age After Five Years

DELIMITER //
CREATE FUNCTION AgeAfterFiveYears(a INT)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN a + 5;
END //
DELIMITER ;

SELECT AgeAfterFiveYears(20);


-- 20. Display Student Name, Marks and Grade

SELECT StudentName, Marks,
       StudentGrade(Marks) AS Grade
FROM Student;