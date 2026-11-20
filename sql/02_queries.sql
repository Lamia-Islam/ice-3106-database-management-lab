-- Q1 selection and ordering
SELECT name, cgpa FROM student WHERE cgpa >= 3.3 ORDER BY cgpa DESC;
-- Q2 join: courses with teacher and department
SELECT c.course_id, c.title, t.name AS teacher, d.name AS dept FROM course c JOIN teacher t USING (teacher_id) JOIN department d ON d.dept_id = t.dept_id ORDER BY c.course_id;
-- Q3 aggregate: average marks per course
SELECT course_id, COUNT(*) AS students, ROUND(AVG(marks),1) AS avg_marks, MAX(marks) AS top FROM enrolment GROUP BY course_id ORDER BY avg_marks DESC;
-- Q4 having: departments with more than 2 students
SELECT d.name, COUNT(*) AS n FROM student s JOIN department d USING (dept_id) GROUP BY d.name HAVING COUNT(*) > 2;
-- Q5 left join: students with no enrolment
SELECT s.name FROM student s LEFT JOIN enrolment e USING (student_id) WHERE e.student_id IS NULL;
-- Q6 subquery: students scoring above the overall average
SELECT DISTINCT s.name FROM student s JOIN enrolment e USING (student_id) WHERE e.marks > (SELECT AVG(marks) FROM enrolment);
-- Q7 window function: rank within each course
SELECT course_id, student_id, marks, RANK() OVER (PARTITION BY course_id ORDER BY marks DESC) AS rnk FROM enrolment ORDER BY course_id, rnk;
-- Q8 CTE: teachers whose courses average above 75
WITH avg_by_course AS (SELECT course_id, AVG(marks) AS a FROM enrolment GROUP BY course_id) SELECT t.name, ROUND(AVG(a),1) AS avg_of_courses FROM course c JOIN avg_by_course USING (course_id) JOIN teacher t USING (teacher_id) GROUP BY t.name HAVING AVG(a) > 75;
-- Q9 NULL handling
SELECT name, COALESCE(cgpa, 0) AS cgpa_or_zero FROM student WHERE cgpa IS NULL;
-- Q10 view
CREATE VIEW honour_students AS SELECT name, cgpa FROM student WHERE cgpa >= 3.5;
SELECT * FROM honour_students;
