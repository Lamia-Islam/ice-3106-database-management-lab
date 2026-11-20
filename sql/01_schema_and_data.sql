-- University database: students, courses, enrolments, teachers
PRAGMA foreign_keys = ON;
CREATE TABLE department (dept_id INTEGER PRIMARY KEY, name TEXT NOT NULL UNIQUE);
CREATE TABLE teacher (teacher_id INTEGER PRIMARY KEY, name TEXT NOT NULL, dept_id INTEGER REFERENCES department(dept_id), salary REAL CHECK (salary > 0));
CREATE TABLE student (student_id INTEGER PRIMARY KEY, name TEXT NOT NULL, dept_id INTEGER REFERENCES department(dept_id), year INTEGER CHECK (year BETWEEN 1 AND 4), cgpa REAL);
CREATE TABLE course (course_id TEXT PRIMARY KEY, title TEXT NOT NULL, credits REAL NOT NULL, teacher_id INTEGER REFERENCES teacher(teacher_id));
CREATE TABLE enrolment (student_id INTEGER REFERENCES student(student_id) ON DELETE CASCADE, course_id TEXT REFERENCES course(course_id), marks REAL, PRIMARY KEY (student_id, course_id));
INSERT INTO department VALUES (1,'ICE'),(2,'CSE'),(3,'EEE');
INSERT INTO teacher VALUES (1,'Teacher A',1,90000),(2,'Teacher B',1,75000),(3,'Teacher C',2,82000),(4,'Teacher D',3,70000);
INSERT INTO student VALUES (1,'Student 1',1,4,3.41),(2,'Student 2',1,4,3.72),(3,'Student 3',1,3,3.10),(4,'Student 4',2,3,3.55),(5,'Student 5',2,2,2.90),(6,'Student 6',3,2,3.25),(7,'Student 7',1,1,NULL);
INSERT INTO course VALUES ('ICE-4101','Data Communication',3,1),('ICE-4105','Information Theory',3,2),('ICE-4107','Cryptography',3,1),('CSE-2201','Algorithms',3,3),('EEE-1101','Circuits',3,4);
INSERT INTO enrolment VALUES (1,'ICE-4101',78),(1,'ICE-4105',85),(1,'ICE-4107',72),(2,'ICE-4101',91),(2,'ICE-4105',88),(3,'ICE-4101',66),(3,'ICE-4107',59),(4,'CSE-2201',80),(5,'CSE-2201',54),(6,'EEE-1101',73),(4,'ICE-4105',69);
