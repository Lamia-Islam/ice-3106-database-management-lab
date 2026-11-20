# ICE-3106: Database Management Systems Sessional

SQL lab built from the course syllabus: schema design with keys and constraints, queries from simple selection to joins, aggregates, subqueries, window functions and CTEs, then views, triggers, transactions and indexes. Runs on SQLite.

These are written from the syllabus topics. They are not my original lab questions, which I no longer have.

## Contents

| File | Purpose |
|---|---|
| `sql/01_schema_and_data.sql` | Five related tables (department, teacher, student, course, enrolment) with primary keys, foreign keys, CHECK and UNIQUE constraints, and sample data |
| `sql/02_queries.sql` | Ten queries covering selection, joins, GROUP BY and HAVING, LEFT JOIN, subquery, window function, CTE, NULL handling and a view |
| `python/run_sql.py` | Runs everything, then shows a trigger and audit table, a transaction rollback, constraint violations and the effect of an index |
| `results/database_output.txt` | Output of every query |
| `sql/01_schema.sql`, `sql/02_data.sql`, `sql/03_queries.sql` | A second, separate version of the same exercise with an instructor-based university schema and a longer query set, run from the `sqlite3` shell |
| `NORMALIZATION.md` | Worked example of normalising a flat table to 3NF, leading to the schema in `sql/01_schema.sql` |
| `results/query_output.txt` | Output of the second query set |
| `results/university.db` | The SQLite database built by the second version |

## Run

```bash
python python/run_sql.py
```

No packages are needed beyond Python's built-in `sqlite3`.

## Notes and limitations

- The names and marks are made-up sample data.
- SQLite has no stored procedures and is lenient about types, so some MySQL or PostgreSQL features taught in the course are not shown.
- Index timings depend on the machine; what matters is the large gap and the change in the query plan from a full scan to an index search.
