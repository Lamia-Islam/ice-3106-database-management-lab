.headers on
.mode column
.print '--- 1. Selection and projection: ICE students in year 4'
SELECT name, year FROM student WHERE dept_id = 1 AND year = 4;
.print '--- 2. Join: student, course and grade'
SELECT s.name, c.title, e.grade FROM enrollment e JOIN student s USING (stu_id) JOIN course c USING (course_id) WHERE e.grade >= 3.5 ORDER BY e.grade DESC;
.print '--- 3. Aggregate with GROUP BY and HAVING: average grade per course (at least 2 students)'
SELECT c.title, COUNT(*) AS students, ROUND(AVG(e.grade), 2) AS avg_grade FROM enrollment e JOIN course c USING (course_id) GROUP BY c.course_id HAVING COUNT(*) >= 2 ORDER BY avg_grade DESC;
.print '--- 4. Outer join: students with no grade yet or no enrolment'
SELECT s.name, e.course_id, e.grade FROM student s LEFT JOIN enrollment e USING (stu_id) WHERE e.stu_id IS NULL OR e.grade IS NULL;
.print '--- 5. Subquery: instructors earning more than the average of their department'
SELECT name, salary FROM instructor i WHERE salary > (SELECT AVG(salary) FROM instructor WHERE dept_id = i.dept_id);
.print '--- 6. Division (relational algebra): students enrolled in every ICE-4xxx course'
SELECT s.name FROM student s WHERE NOT EXISTS (SELECT course_id FROM course WHERE course_id LIKE 'ICE-4%' AND course_id NOT IN (SELECT course_id FROM enrollment WHERE stu_id = s.stu_id));
.print '--- 7. Set operation EXCEPT: instructors who teach no course'
SELECT inst_id, name FROM instructor WHERE inst_id IN (SELECT inst_id FROM instructor EXCEPT SELECT inst_id FROM teaches);
.print '--- 8. Window function: rank of students by grade within each course'
SELECT course_id, stu_id, grade, RANK() OVER (PARTITION BY course_id ORDER BY grade DESC) AS rank FROM enrollment WHERE grade IS NOT NULL ORDER BY course_id, rank;
.print '--- 9. Recursive CTE: numbers 1 to 5'
WITH RECURSIVE n(i) AS (SELECT 1 UNION ALL SELECT i + 1 FROM n WHERE i < 5) SELECT i FROM n;
.print '--- 10. View'
CREATE VIEW transcript AS SELECT s.name AS student, c.title AS course, e.grade FROM enrollment e JOIN student s USING (stu_id) JOIN course c USING (course_id);
SELECT * FROM transcript WHERE student = 'Anika';
.print '--- 11. Trigger: log every grade change'
CREATE TRIGGER grade_change AFTER UPDATE OF grade ON enrollment BEGIN INSERT INTO audit_log(note) VALUES ('student ' || OLD.stu_id || ' ' || OLD.course_id || ': ' || IFNULL(OLD.grade,'NULL') || ' -> ' || NEW.grade); END;
UPDATE enrollment SET grade = 2.9 WHERE stu_id = 8 AND course_id = 'CSE-2201';
SELECT note FROM audit_log;
.print '--- 12. Constraint violations are rejected'
INSERT INTO student VALUES (99, 'Bad', 77, 2);
INSERT INTO enrollment VALUES (1, 'ICE-4101', 9.9);
.print '--- 13. Transaction rollback'
BEGIN;
DELETE FROM enrollment;
SELECT COUNT(*) AS rows_inside_transaction FROM enrollment;
ROLLBACK;
SELECT COUNT(*) AS rows_after_rollback FROM enrollment;
.print '--- 14. Indexing: query plan before and after creating an index'
EXPLAIN QUERY PLAN SELECT * FROM student WHERE name = 'Dipu';
CREATE INDEX idx_student_name ON student(name);
EXPLAIN QUERY PLAN SELECT * FROM student WHERE name = 'Dipu';
