 SELECT *
 FROM employees
 LIMIT 20;

--D1_Steps1-7
--Retrieve the emp_no, first_name, and last_name columns from Employees table.
---Retrieve the title, from_date, and to_date columns from Titles table.
--Join employees and titles table into new table called retirement titles.
SELECT
	A.emp_no
	, B.first_name
	, B.last_name
	, A.title
	, A.from_date
	, A.to_date
	, B.birth_date
 INTO retirement_titles
 FROM titles A
 LEFT JOIN employees B
 ON A.emp_no = B.emp_no
 WHERE B.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
 ORDER BY A.emp_no
 
 SELECT *
 FROM retirement_titles
 LIMIT 20;
 
 --D1_Steps10-15
 -- Use Dictinct with Orderby to remove duplicate rows
 
DROP TABLE unique_titles;

----create table unique titles table
SELECT
DISTINCT ON (emp_no) emp_no,
	first_name,
	last_name,
	title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
;

SELECT *
FROM unique_titles
LIMIT 20; 


--D1_Step16-21. Retrieve number of employees by their most recent job title who are about to retire.

--#17 Retrieve total titles from Unique Titles table and
--#19 Group the table by title, then sort the count column in descending order.
--#18 Create a Retiring Titles table to hold the required information.

SELECT title
, COUNT (title)AS "title_count"
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY "title_count" DESC; 

SELECT title_count, title
FROM retiring_titles
LIMIT 10;

SELECT *
FROM retiring_titles
LIMIT 20;


-----Deliverable 2: The Employees Eligible for the Mentorship Program------

--#1-8
--Join the Employees and the Department Employee tables on the primary key.
--Join the Employees and the Titles tables on the primary key.
--#8 Employees DOB between 1/1/1965 and 12/31/1965.  DOB only exists in employees table.

--DROP TABLE mentorship_eligibilty

SELECT DISTINCT ON (emp_no)
	A.emp_no
	, A.first_name
	, A.last_name
	, A.birth_date
	, B.from_date
	, B.to_date
	, C.title
INTO mentorship_eligibilty
FROM employees AS A
JOIN dept_emp AS B
ON A.emp_no = B.emp_no
JOIN titles AS C
ON A.emp_no = C.emp_no
WHERE A.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
AND B.to_date = '9999-01-01'
ORDER BY emp_no, first_name, last_name, birth_date, to_date, title
; 

SELECT *
FROM mentorship_eligibilty
LIMIT 10;

--------------------DELIVERABLE3-------------------------- 
--Retiring_Titles table pulled employees DOB 1952-1955; 
----Tally total number of employees retiring.

SELECT *
FROM retiring_titles

SELECT SUM (title_count) AS "TOTALEmployeesRetiring"
FROM retiring_titles;

--Mentorship_eligibilty table pulled employees DOB 1965; 
----These employees will retire AFTER 1952-1955 DOB employees.

SELECT *
FROM mentorship_eligibilty

--Tally total number of Mentor Eligible employees born in 1965 by Job.
---Save table as EligibleMentors_byJob

SELECT title
, COUNT (title)AS "MentorTitleCount"
INTO EligibleMentors_byJob
FROM mentorship_eligibilty
GROUP BY title
ORDER BY "MentorTitleCount" DESC; 

SELECT *
FROM EligibleMentors_byJob

--Total number of Mentor Eligible employees born in 1965.

SELECT COUNT (*)
FROM mentorship_eligibilty





