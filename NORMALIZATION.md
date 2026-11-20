# Normalisation example

Start with one flat table of enrolments:

`enrol(stu_id, stu_name, dept_name, building, course_id, course_title, credits, grade)`

| Problem | Where it shows up |
|---|---|
| Update anomaly | Changing a department's building means editing every row for every student in it |
| Insert anomaly | A course cannot be stored until a student enrols in it |
| Delete anomaly | Deleting the last enrolment of a course loses the course title |

Functional dependencies: `stu_id -> stu_name, dept_name`, `dept_name -> building`, `course_id -> course_title, credits`, `(stu_id, course_id) -> grade`.

- **1NF:** every cell holds one value (already true).
- **2NF:** remove partial dependencies on the key `(stu_id, course_id)`. Student attributes move to `student`, course attributes move to `course`, leaving `enrollment(stu_id, course_id, grade)`.
- **3NF:** remove the transitive dependency `stu_id -> dept_name -> building`. Department attributes move to `department`.

The result is the schema in `sql/01_schema.sql`.
