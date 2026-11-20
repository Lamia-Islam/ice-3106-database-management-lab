-- University database: ER model converted to relational tables
PRAGMA foreign_keys = ON;
CREATE TABLE department (dept_id INTEGER PRIMARY KEY, name TEXT NOT NULL UNIQUE, building TEXT);
CREATE TABLE instructor (inst_id INTEGER PRIMARY KEY, name TEXT NOT NULL, dept_id INTEGER NOT NULL REFERENCES department(dept_id), salary REAL CHECK (salary > 0));
CREATE TABLE student (stu_id INTEGER PRIMARY KEY, name TEXT NOT NULL, dept_id INTEGER NOT NULL REFERENCES department(dept_id), year INTEGER CHECK (year BETWEEN 1 AND 4));
CREATE TABLE course (course_id TEXT PRIMARY KEY, title TEXT NOT NULL, credits REAL NOT NULL, dept_id INTEGER NOT NULL REFERENCES department(dept_id));
CREATE TABLE teaches (inst_id INTEGER REFERENCES instructor(inst_id), course_id TEXT REFERENCES course(course_id), PRIMARY KEY (inst_id, course_id));
CREATE TABLE enrollment (stu_id INTEGER REFERENCES student(stu_id), course_id TEXT REFERENCES course(course_id), grade REAL CHECK (grade BETWEEN 0 AND 4), PRIMARY KEY (stu_id, course_id));
CREATE TABLE audit_log (id INTEGER PRIMARY KEY AUTOINCREMENT, note TEXT, at TEXT DEFAULT CURRENT_TIMESTAMP);
