-- Part A: database design

-- First, create databses for Remarkable University

DROP DATABASE IF EXISTS Remarkable_University;
CREATE DATABASE IF NOT EXISTS Remarkable_University;
USE Remarkable_University;


-- Create a table for Remarkable University's department

DROP TABLE if EXISTS department;
CREATE TABLE department (
	dept_id CHAR(4) NOT NULL,
	dept_name VARCHAR(30) NOT NULL,
	CONSTRAINT dept_PK PRIMARY KEY (dept_id),
	UNIQUE(dept_name)
);

-- Insert values to the department table

INSERT INTO department VALUES ('D1','Academic');
INSERT INTO department VALUES ('D2','Admin');
INSERT INTO department VALUES ('D3','IT');


-- Create a role table for staff

DROP TABLE if EXISTS role;
CREATE TABLE role (
	role_id CHAR(4) NOT NULL,
	role VARCHAR(30) NOT NULL,
	CONSTRAINT role_PK PRIMARY KEY (role_id),
	UNIQUE(role)
);

-- Insert values to the role table

INSERT INTO role VALUES ('R1','Professor');
INSERT INTO role VALUES ('R2','Asso. Professor');
INSERT INTO role VALUES ('R3','Lecturer');
INSERT INTO role VALUES ('R4','Enrolment Controller');
INSERT INTO role VALUES ('R5','Course Controller');
INSERT INTO role VALUES ('R6','DBA');


-- Create a table to store staff information, such as roles, departments, and personal information

DROP TABLE if EXISTS staff;
CREATE TABLE staff (
	staff_id CHAR(4) NOT NULL,
	dept_id CHAR(4) NOT NULL,
	role_id CHAR(4) NOT NULL,
	first_name VARCHAR(25) NOT NULL,
	last_name VARCHAR(25) NOT NULL,
	phone INT(20) NOT NULL,
	CONSTRAINT staff_PK PRIMARY KEY (staff_id),
	CONSTRAINT staff_dept_id_FK FOREIGN KEY (dept_id) REFERENCES department (dept_id) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT staff_role_id_FK FOREIGN KEY (role_id) REFERENCES role (role_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Insert values into the staff table

INSERT INTO staff VALUES ('S01','D1','R1','Seb','Binary',465796);
INSERT INTO staff VALUES ('S02','D1','R2','Jazz','Wood',246678);	
INSERT INTO staff VALUES ('S03','D1','R3','Miguel','Franco',291880);
INSERT INTO staff VALUES ('S04','D2','R4','Cristiano','Penaldo',294472);
INSERT INTO staff VALUES ('S05','D2','R5','Lionel','Missy',497124);
INSERT INTO staff VALUES ('S06','D3','R6','Bruce','Whyne',364315);


-- Create a table to store campus location

DROP TABLE if EXISTS campus;
CREATE TABLE campus (
	campus_id CHAR(4) NOT NULL,
	campus_name VARCHAR(25) NOT NULL,
	CONSTRAINT campus_PK PRIMARY KEY (campus_id),
	UNIQUE(campus_name)
);

-- Insert values to the campus table

INSERT INTO campus VALUES ('CA1','Nathan');
INSERT INTO campus VALUES ('CA2','Goldcoast');


-- Create a table to store courses's information

DROP TABLE if EXISTS course;
CREATE TABLE course (
	course_id CHAR(6) NOT NULL,
	staff_id CHAR(4) NOT NULL,
	course_name VARCHAR(40) NOT NULL,
	UNIQUE(course_name),
	CONSTRAINT course_id_PK PRIMARY KEY (course_id),
	CONSTRAINT course_staff_id_FK FOREIGN KEY (staff_id) REFERENCES staff (staff_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Insert values to the course table

INSERT INTO course VALUES ('101ICT','S01','Information Management');
INSERT INTO course VALUES ('102ICT','S02','Object Oriented Programming');
INSERT INTO course VALUES ('101STA','S02','Statistics');
INSERT INTO course VALUES ('101CS','S01','Data Analytics');
INSERT INTO course VALUES ('102CS','S03','Information Retrieval');


-- Create a table to store information about the available courses in each trimester for each year

DROP TABLE if EXISTS class;
CREATE TABLE class (
	class_id CHAR(4) NOT NULL,
	course_id CHAR(6) NOT NULL,
	campus_id CHAR(4) NOT NULL,
	trimester INT(4) NOT NULL,
	CONSTRAINT class_PK PRIMARY KEY (class_id),
	CONSTRAINT class_course_id_FK FOREIGN KEY (course_id) REFERENCES course (course_id) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT class_campus_id_FK FOREIGN KEY (campus_id) REFERENCES campus (campus_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Insert values to the class table

INSERT INTO class VALUES ('CL01','101ICT','CA2',1);
INSERT INTO class VALUES ('CL02','101ICT','CA2',2);
INSERT INTO class VALUES ('CL03','102ICT','CA1',2);
INSERT INTO class VALUES ('CL04','101STA','CA1',1);
INSERT INTO class VALUES ('CL05','101STA','CA2',1);
INSERT INTO class VALUES ('CL06','101CS','CA2',1);
INSERT INTO class VALUES ('CL07','102CS','CA2',1);
INSERT INTO class VALUES ('CL08','102CS','CA2',3);


-- Create a table to store students' information

DROP TABLE if EXISTS student;
CREATE TABLE student (
	student_id CHAR(4) NOT NULL,
	first_name VARCHAR(25) NOT NULL,
	last_name VARCHAR(25) NOT NULL,
	DOB DATE NOT NULL,
	sex ENUM('M','F') NOT NULL,
	phone INT(20) NOT NULL,
	CONSTRAINT student_PK PRIMARY KEY (student_id)
);

--  Insert values to the student table

INSERT INTO student VALUES ('ST01','Angela','Merkal','1991-01-01','F',543210);
INSERT INTO student VALUES ('ST02','Donaldo','True','1992-02-02','M',123456);
INSERT INTO student VALUES ('ST03','Hillarious','Blinton','1993-03-03','F',112233);
INSERT INTO student VALUES ('ST04','Tarra','Obana','1994-04-04','M',221134);


-- Create a table to store staff user ID and password

DROP TABLE if EXISTS useraccount_staff;
CREATE TABLE useraccount_staff (
	user_staff_id CHAR(4) NOT NULL,
	staff_id CHAR(4) NOT NULL,
	password VARCHAR(50) NOT NULL,
	CONSTRAINT useraccount_staff_PK PRIMARY KEY (user_staff_id),
	CONSTRAINT useraccount_staff_staff_id_FK FOREIGN KEY (staff_id) REFERENCES staff (staff_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Insert values to the useraccount_staff table

INSERT INTO useraccount_staff VALUES ('US01','S01',SHA1('123'));
INSERT INTO useraccount_staff VALUES ('US02','S02',SHA1('520'));
INSERT INTO useraccount_staff VALUES ('US03','S03',SHA1('886'));
INSERT INTO useraccount_staff VALUES ('US04','S04',SHA1('897'));
INSERT INTO useraccount_staff VALUES ('US05','S05',SHA1('777'));
INSERT INTO useraccount_staff VALUES ('US06','S06',SHA1('555'));

-- Note: SHA1 is a cryptogreaphic hash function which converts the passwords to hexadecimal numbers
-- Note: this is just a table that store staff user ID and passwords


-- create a table to store student's user ID and passwords

DROP TABLE if EXISTS useraccount_student;
CREATE TABLE useraccount_student (
	user_student_id CHAR(5) NOT NULL,
	student_id CHAR(4) NOT NULL,
	password VARCHAR(50) NOT NULL,
	CONSTRAINT useraccount_student_PK PRIMARY KEY (user_student_id),
	CONSTRAINT useraccount_student_student_id_FK FOREIGN KEY (student_id) REFERENCES student (student_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Insert values to the eraccount_student table

INSERT INTO useraccount_student VALUES ('UST01','ST01',SHA1('888'));
INSERT INTO useraccount_student VALUES ('UST02','ST02',SHA1('867'));
INSERT INTO useraccount_student VALUES ('UST03','ST03',SHA1('111'));
INSERT INTO useraccount_student VALUES ('UST04','ST04',SHA1('889'));

-- Note: SHA1 is a cryptogreaphic hash function which converts the passwords to hexadecimal numbers
-- Note: this is just a table that store staff user ID and passwords


-- Create a table to store students' enrolment information

DROP TABLE if EXISTS enrolment;
CREATE TABLE enrolment (
	enrolment_id CHAR(4) NOT NULL,
	user_student_id CHAR(5) NOT NULL,
	student_id CHAR(4) NOT NULL,
	class_id CHAR(4) NOT NULL,
	year YEAR NOT NULL,
	CONSTRAINT enrolment_PK PRIMARY KEY (enrolment_id),
	CONSTRAINT enrolment_user_student_id_FK FOREIGN KEY (user_student_id) REFERENCES useraccount_student (user_student_id) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT enrolment_student_id_FK FOREIGN KEY (student_id) REFERENCES student (student_id) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT enrolment_class_id_FK FOREIGN KEY (class_id) REFERENCES class (class_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Insert values to the enrolment table

INSERT INTO enrolment VALUES ('E01','UST01','ST01','CL01','2017');
INSERT INTO enrolment VALUES ('E02','UST01','ST01','CL05','2017');
INSERT INTO enrolment VALUES ('E03','UST01','ST01','CL06','2017');
INSERT INTO enrolment VALUES ('E04','UST02','ST02','CL03','2018');
INSERT INTO enrolment VALUES ('E05','UST02','ST02','CL06','2017');
INSERT INTO enrolment VALUES ('E06','UST03','ST03','CL08','2018');
INSERT INTO enrolment VALUES ('E07','UST04','ST04','CL03','2018');
INSERT INTO enrolment VALUES ('E08','UST04','ST04','CL04','2017');
INSERT INTO enrolment VALUES ('E09','UST04','ST04','CL06','2017');
INSERT INTO enrolment VALUES ('E10','UST04','ST04','CL07','2018');


-- Create a table to store grade data for students after the exam

DROP TABLE if EXISTS grade;
CREATE TABLE grade (
	enrolment_id CHAR(4) NOT NULL,
	score INT(3) NOT NULL,
	grade INT(2) NOT NULL,
	CONSTRAINT grade_enrolment_id_FK FOREIGN KEY (enrolment_id) REFERENCES enrolment (enrolment_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Insert values to the grade table

INSERT INTO grade VALUES ('E01',75,6);
INSERT INTO grade VALUES ('E02',80,6);
INSERT INTO grade VALUES ('E03',92,7);
INSERT INTO grade VALUES ('E04',86,7);
INSERT INTO grade VALUES ('E05',71,5);
INSERT INTO grade VALUES ('E06',65,5);
INSERT INTO grade VALUES ('E07',55,4);
INSERT INTO grade VALUES ('E08',66,5);
INSERT INTO grade VALUES ('E09',80,6);
INSERT INTO grade VALUES ('E10',86,7);


-- Part B. User and Privileges


-- Create user account for student's

DROP USER IF EXISTS 'UST01' @'%';
DROP USER IF EXISTS 'UST02' @'%';
DROP USER IF EXISTS 'UST03' @'%';
DROP USER IF EXISTS 'UST04' @'%';

CREATE USER 'UST01' @'%' IDENTIFIED BY '888';
CREATE USER 'UST02' @'%' IDENTIFIED BY '111';
CREATE USER 'UST03' @'%' IDENTIFIED BY '678';
CREATE USER 'UST04' @'%' IDENTIFIED BY '889';

-- Create user account for academic staff

DROP USER IF EXISTS 'US01' @'%';
DROP USER IF EXISTS 'US02' @'%';
DROP USER IF EXISTS 'US03' @'%';

CREATE USER 'US01' @'%' IDENTIFIED BY '123';
CREATE USER 'US02' @'%' IDENTIFIED BY '520';
CREATE USER 'US03' @'%' IDENTIFIED BY '886';

-- Create user account for admin staff_enrolment controller

DROP USER IF EXISTS 'US04' @'%';
CREATE USER 'US04' @'%' IDENTIFIED BY '897';

-- Create user account for admin staff_course controller

DROP USER IF EXISTS 'US05' @'%';
CREATE USER 'US05' @'%' IDENTIFIED BY '777';

-- Create user account for database administrator

DROP USER IF EXISTS 'US06' @'%';
CREATE USER 'US06' @'%' IDENTIFIED BY '555';


-- Grant Privileges



-- Grant ALL privilleges on enrolment table to admin staff_enrolment controller

GRANT ALL ON Remarkable_University.enrolment TO US04 @'%';

-- Grant ALL privilleges on course table to admin staff_course controller

GRANT ALL ON Remarkable_University.course TO US05 @'%';


-- Grant ALL on course table for academic staff

GRANT ALL ON Remarkable_University.course TO US01, US02, US03 @'%';

-- Grant SELECT on course table for students

GRANT SELECT ON Remarkable_University.course TO UST01, UST02, UST03, UST04 @'%';


-- Grant SELECT on name and sex of the students only to academic staff 

GRANT SELECT(first_name, last_name, sex) ON Remarkable_University.student TO US01, US02, US03 @'%';


-- Grant ALL privileges of the entire DB to DBA with GRANT OPTION

GRANT ALL ON *.* TO US06 @'%' WITH GRANT OPTION;


-- Grant select privilege on department and role table to the staff inside the university

GRANT SELECT ON department TO 'US01'@'%', 'US02'@'%', 'US03'@'%', 'US04'@'%', 'US05'@'%';
GRANT SELECT ON role TO 'US01'@'%', 'US02'@'%', 'US03'@'%', 'US04'@'%', 'US05'@'%';

-- Create view and its associate privileges


-- Create view and let students to see only their grade

CREATE VIEW Remarkable_University.my_grade as
	SELECT enrolment.user_student_id, enrolment.class_id, course.course_name, grade.grade FROM Remarkable_University.enrolment, Remarkable_University.course, Remarkable_University.class, Remarkable_University.grade
    WHERE enrolment.enrolment_id = grade.enrolment_id AND enrolment.class_id = class.class_id AND class.course_id = course.course_id AND enrolment.user_student_id = 'UST01';
    
    
GRANT SELECT ON my_grade TO UST01 @'%';



-- Create a view that allow the acadmeic staff to see only the students that enrolled in their course

DROP VIEW IF EXISTS 102CS_enrolment;
CREATE VIEW Remarkable_University.102CS_enrolment as
	SELECT enrolment.enrolment_id, enrolment.user_student_id, student.first_name, student.last_name, class.course_id, class.campus_id, class.trimester, enrolment.year FROM Remarkable_University.enrolment, Remarkable_University.class, Remarkable_University.student
    WHERE enrolment.class_id = class.class_id AND enrolment.student_id = student.student_id AND class.course_id = '102CS';
    
    
GRANT SELECT ON 102CS_enrolment TO US03 @'%';



-- Create a view that allows the academic staff to see and modify the grade of the course that they teach

DROP VIEW IF EXISTS 102CS_student_grade;
CREATE VIEW Remarkable_University.102CS_student_grade as
	SELECT grade.enrolment_id, class.course_id, grade.score, grade.grade FROM Remarkable_University.grade, Remarkable_University.enrolment, Remarkable_University.class
    WHERE enrolment.enrolment_id = grade.enrolment_id AND enrolment.class_id = class.class_id AND class.course_id='102CS';
    
    
GRANT ALL ON 102CS_student_grade TO US03 @'%';



-- Create a view and grant a privilege to the adcademic staff to see only the staff in their department

DROP VIEW IF EXISTS my_department;
CREATE VIEW Remarkable_University.my_department as
	SELECT * FROM Remarkable_University.staff
    WHERE staff.dept_id = 'D1';
    
    
GRANT SELECT ON my_department TO US03 @'%';




-- Create a view and grant a privilege to let the academic staff to view other staff information (staff name & department name only) at other department

DROP VIEW IF EXISTS other_department;
CREATE VIEW Remarkable_University.other_department as
	SELECT staff.staff_id, department.dept_name, staff.first_name, staff.last_name FROM Remarkable_University.staff, Remarkable_University.department
    WHERE staff.dept_id = department.dept_id AND staff.dept_id != 'D1';
    
    
GRANT ALL ON other_department TO US03 @'%';
























