"""Runs the SQL files on an in-memory SQLite database, then demonstrates indexes, triggers, transactions and constraints."""
import sqlite3, os, time
HERE = os.path.dirname(__file__); OUT = os.path.join(HERE, "..", "results"); lines = []
def say(s=""): print(s); lines.append(s)
db = sqlite3.connect(":memory:", isolation_level=None); db.executescript(open(os.path.join(HERE, "..", "sql", "01_schema_and_data.sql")).read())
def show(sql):
    cur = db.execute(sql); cols = [c[0] for c in cur.description] if cur.description else []; rows = cur.fetchall()
    say("  " + " | ".join(cols)); [say("  " + " | ".join(str(v) for v in r)) for r in rows]
for stmt in [s.strip() for s in open(os.path.join(HERE, "..", "sql", "02_queries.sql")).read().split(";") if s.strip()]:
    title = stmt.splitlines()[0]; say(title); body = "\n".join(l for l in stmt.splitlines() if not l.startswith("--"))
    if body.upper().startswith("CREATE"): db.execute(body); continue
    show(body); say()
say("-- Trigger: log every mark change")
db.executescript("CREATE TABLE audit (id INTEGER PRIMARY KEY, student_id INT, course_id TEXT, old REAL, new REAL); CREATE TRIGGER mark_change AFTER UPDATE OF marks ON enrolment BEGIN INSERT INTO audit(student_id, course_id, old, new) VALUES (OLD.student_id, OLD.course_id, OLD.marks, NEW.marks); END;")
db.execute("UPDATE enrolment SET marks = 70 WHERE student_id = 3 AND course_id = 'ICE-4101'"); show("SELECT * FROM audit"); say()
say("-- Transaction rollback")
try:
    db.execute("BEGIN"); db.execute("UPDATE student SET cgpa = 4.0 WHERE student_id = 5"); db.execute("INSERT INTO enrolment VALUES (99,'ICE-4101',50)")
except sqlite3.IntegrityError as e: db.execute("ROLLBACK"); say("  error: %s -> rolled back" % e)
show("SELECT cgpa FROM student WHERE student_id = 5"); say("  (cgpa is still 2.9, so the failed insert undid the update)"); say()
say("-- Constraints")
for sql in ["INSERT INTO student VALUES (50,'X',1,9,3.0)", "INSERT INTO department VALUES (9,'ICE')", "INSERT INTO teacher VALUES (9,'Y',1,-5)"]:
    try: db.execute(sql)
    except sqlite3.IntegrityError as e: say("  rejected: %s" % e)
say(); say("-- Index effect on 200000 rows")
db.execute("CREATE TABLE big (id INTEGER, v INTEGER)"); db.executemany("INSERT INTO big VALUES (?,?)", [(i, i * 7 % 100003) for i in range(200000)])
t0 = time.perf_counter(); [db.execute("SELECT * FROM big WHERE v = ?", (k,)).fetchall() for k in range(50)]; a = time.perf_counter() - t0
db.execute("CREATE INDEX idx_v ON big(v)"); t0 = time.perf_counter(); [db.execute("SELECT * FROM big WHERE v = ?", (k,)).fetchall() for k in range(50)]; b = time.perf_counter() - t0
say("  50 lookups without index: %.1f ms, with index: %.2f ms" % (a * 1e3, b * 1e3)); show("EXPLAIN QUERY PLAN SELECT * FROM big WHERE v = 5")
open(os.path.join(OUT, "database_output.txt"), "w").write("\n".join(lines) + "\n")
