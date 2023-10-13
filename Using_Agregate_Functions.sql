
DROP Table if exists gerrard
CREATE TABLE gerrard (
	student_id INTEGER,     
	name VARCHAR(55),     
	admitted_at DATE,     
	age INTEGER,     
	grade DECIMAL(2,1),
	entry_date DATETIME,
	department VARCHAR(55),
	amount_paid DECIMAL(8,2)
);

INSERT INTO gerrard  Values
(1, 'Emmanuel Ayomide', '2015-09-01', 27, 3.8, '2015-09-01 13:21:59', 'Biochemistry', 29200),
(2, 'Ibrahim Musa', '2017-09-01', 24, 4.0, '2017-09-01 11:13:51', 'Biochemistry', 31350),
(3, 'Sesan Obi', '2016-09-01', 24, 3.7, '2016-09-01 14:19:23', 'Sociology', 30000),
(4, 'Kevin Frank', '2015-09-01', 25, 4.0, '2015-09-01 10:11:34', 'Physics', 26410),
(5, 'Emeka Jude', '2014-09-01', 24, 3.8, '2014-09-01 15:12:21', 'Biochemistry', 29200),
(6, 'Carolie Obi', '2013-09-01', 27, 3.1, '2013-09-01 12:12:36', 'Electrical Engineering', 42360),
(7, 'Franklin Oladele', '2019-09-01', 18, 3.9, '2019-09-01 10:00:00', 'Sociology', 31350),
(8, 'Kola Ola', '2013-09-01', 29, 4.0, '2013-09-01 11:10:21', 'Electrical Engineering', 26000),
(9, 'Emmanuel Ovi', '2016-09-01', 23, 3.1, '2016-09-01 11:59:59', 'Statistics', 42360),
(10, 'Kareem Musa', '2016-09-01', 24, 3.3, '2016-09-01 10:11:21', 'Statistics', 26890),
(11, 'Mustapha Ahmed', '2016-09-01', 24, 3.9, '2016-09-01 15:11:20', 'Statistics', 27110),
(12, 'Femi Akin', '2017-09-01', 24, NULL, '2017-09-01 09:11:32', 'Physics', 26410)



--COUNT FN

SELECT COUNT(*)
FROM gerrard
WHERE amount_paid > 28000;


--MAXIMUM FN

SELECT MAX(age)
FROM gerrard;


SELECT MAX(age)
FROM gerrard
WHERE department = 'Biochemistry';


--MINIMUM FN

SELECT MIN(age)
FROM gerrard
WHERE department = 'Biochemistry';


SELECT MIN(age)
FROM gerrard
WHERE department = 'Statistics';


--AVERAGE FN

SELECT AVG(amount_paid)
FROM gerrard;


-
SELECT ROUND (AVG(amount_paid), 2)
FROM gerrard;


SELECT ROUND (AVG(amount_paid), 2)
FROM gerrard
WHERE admitted_at = '2015-09-01';


--SUM FN

SELECT SUM(amount_paid)
FROM gerrard;



SELECT SUM(amount_paid)
FROM gerrard
WHERE department = 'Statistics';


--GROUP BY

--Return the distinct name of the departments in the student table.

SELECT department
FROM gerrard
GROUP BY department;

--How many transactions occured per department.

SELECT department, COUNT(amount_paid)
FROM gerrard
GROUP BY department;

--Total amount paid by each department.

SELECT department, SUM(amount_paid)
FROM gerrard
GROUP BY department;

--Total amount paid by each department per admission date.

SELECT department, admitted_at, SUM(amount_paid)
FROM gerrard
GROUP BY department, admitted_at;


--Total amount paid per admission date, and sort the result.

SELECT admitted_at, SUM(amount_paid)
FROM gerrard
GROUP BY admitted_at
ORDER BY admitted_at DESC;

-

SELECT admitted_at, SUM(amount_paid)
FROM gerrard
GROUP BY admitted_at
ORDER BY sum(amount_paid) DESC;

--Total amount paid per admission date for date after 2014, and sort the result.

SELECT admitted_at, SUM(amount_paid)
FROM gerrard
WHERE admitted_at > '2014-09-01'
GROUP BY admitted_at
ORDER BY sum(amount_paid) ASC;


--HAVING CLAUSE---------------

--How many transactions occurred per department, where the count is more than 2.

SELECT department, COUNT(*)
FROM gerrard
GROUP BY department;



SELECT department, COUNT(*)
FROM gerrard
GROUP BY department
HAVING COUNT(*) > 2;

--Total amount paid by each department per admission date, where the sum is greater than 60,000.

SELECT department, admitted_at, SUM(amount_paid)
FROM gerrard
GROUP BY department, admitted_at
HAVING SUM(amount_paid) > 60000;

--For students that got admitted after 2015, return results for departments that got more than 30,000 in total, and sort the results.

SELECT department, SUM(amount_paid)
FROM gerrard
WHERE admitted_at > '2015-09-01'
GROUP BY department
HAVING SUM(amount_paid) > 30000
ORDER BY SUM(amount_paid);

--HAVING VS WHERE


--JOINS

ALIASES (AS)---

SELECT admitted_at AS date
FROM gerrard;
-
SELECT S.name, S.grade
FROM gerrard AS S;
-
SELECT department, COUNT(*) AS number
FROM gerrard
GROUP BY department;

INNER JOIN---



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

There is a new table, "Project Table" this table contains information on students that completed and submitted their project for review.
Return the results of students who registered (in prooject table) and submitted their projects for review.

MERGING TABLES

SELECT *
FROM gerrard
INNER JOIN project
ON gerrard.student_id = project.student_id;
-
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
LEFT JOIN

Retrun results for all students who submitted a project and those who didn't.
Filter the results to highlight those who did not submit.

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

We have some students who submitted projects, but didn't complete the student's registration (no name in students table).
Return results for this.

SELECT gerrard.student_id, name, department, title, project.student_id
FROM project
LEFT JOIN gerrard
ON gerrard.student_id = project.student_id;

---
RIGHT JOIN

Return results for all studets who submitted a project and those who didn't. Filter the results to hihglight those who did not submit.

SELECT gerrard.student_id, name, department, title
FROM project
RIGHT JOIN gerrard
ON gerrard.student_id = project.student_id;

We have some students who submitted project, but didn't complete the students (no name in students table). Return results for this.

SELECT gerrard.student_id, name, department, title
FROM gerrard
RIGHT JOIN project
ON gerrard.student_id = project.student_id;

---
SUBQUERY--------------------------------------------------------
