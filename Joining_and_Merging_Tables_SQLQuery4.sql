
--INNER JOIN---

CREATE TABLE project (
	id INTEGER,
    student_id INTEGER,
    title VARCHAR(60)
    );

INSERT INTO project (id, student_id, title)
VALUES (1, 2, 'Bioinformatics');

INSERT INTO project (id, student_id, title)
VALUES (2, 1, 'Cell Biology');

INSERT INTO project (id, student_id, title)
VALUES (3, 4, 'Fluid Mechanics');

INSERT INTO project (id, student_id, title)
VALUES (4, 6, 'Magnetism');

INSERT INTO project (id, student_id, title)
VALUES (5, 8, 'Electronics');

INSERT INTO project (id, student_id, title)
VALUES (6, 7, 'Mass Media');

INSERT INTO project (id, student_id, title)
VALUES (7, 5, 'Genetics');

INSERT INTO project (id, student_id, title)
VALUES (8, 3, 'Youth Culture');

INSERT INTO project (id, student_id, title)
VALUES (9, 15, 'Class Conflict');

INSERT INTO project (id, student_id, title)
VALUES (10, 16, 'Instrumentation');

--There is a new table, "Project Table" this table contains information on students that completed and submitted their project for review.
--Return the results of students who registered (in prooject table) and submitted their projects for review.

--MERGING TABLES

SELECT *
FROM gerrard
INNER JOIN project
ON gerrard.student_id = project.student_id;


SELECT gerrard.student_id, name, title
FROM gerrard 
INNER JOIN project 
ON gerrard.student_id = project.student_id;
-
SELECT gerrard.student_id, name, title, department
FROM gerrard 
INNER JOIN project 
ON gerrard.student_id = project.student_id;

---
--LEFT JOIN

--Retrun results for all students who submitted a project and those who didn't.
--Filter the results to highlight those who did not submit.

SELECT gerrard.student_id, name, department, title
FROM gerrard
LEFT JOIN project
ON gerrard.student_id = project.student_id;
-
SELECT gerrard.student_id, name, department, title
FROM gerrard
LEFT JOIN project
ON gerrard.student_id = project.student_id
WHERE project.student_id IS NULL;
-
SELECT gerrard.student_id, name, department, title, project.student_id
FROM gerrard
LEFT JOIN project
ON gerrard.student_id = project.student_id
WHERE project.student_id IS NULL;

--We have some students who submitted projects, but didn't complete the student's registration (no name in students table).
--Return results for this.

SELECT gerrard.student_id, name, department, title, project.student_id
FROM project
LEFT JOIN gerrard
ON gerrard.student_id = project.student_id;

---
--RIGHT JOIN

--Return results for all studets who submitted a project and those who didn't. Filter the results to hihglight those who did not submit.

SELECT gerrard.student_id, name, department, title
FROM project
RIGHT JOIN gerrard
ON gerrard.student_id = project.student_id;

--We have some students who submitted project, but didn't complete the students (no name in students table). Return results for this.

SELECT gerrard.student_id, name, department, title
FROM gerrard
RIGHT JOIN project
ON gerrard.student_id = project.student_id;

