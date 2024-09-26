--1. List the employee number, last name, first name, sex, and salary of each employee.
SELECT
	emp.emp_no,
	emp.last_name,
	emp.first_name,
	emp.sex,
	sal.salary
FROM employees AS emp
LEFT JOIN salaries AS sal ON emp.emp_no = sal.emp_no;

--2. List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT
	first_name,
	last_name,
	hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

--3. List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT
	mang.dept_no,
	dept.dept_name,
	emp.emp_no,
	emp.last_name,
	emp.first_name
FROM employees AS emp
RIGHT JOIN dept_manager AS mang ON mang.emp_no = emp.emp_no
LEFT JOIN departments AS dept ON mang.dept_no = dept.dept_no;

--4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
-- PLEASE NOTE DUE TO THE NATURE OF THE DEPARTMENT/EMPLOYEE TABLE, EMPLOYEES WHO ARE ASSIGNED MULTIPLE DEPARTMETNS WILL BE LISTED MULTIPLE TIMES.
SELECT
	dept.dept_no,
	de.emp_no,
	emp.last_name,
	emp.first_name,
	dept.dept_name
FROM dept_emp AS de
INNER JOIN employees AS emp ON de.emp_no = emp.emp_no
LEFT JOIN departments AS dept ON de.dept_no = dept.dept_no;
	

--5.List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT
	first_name,
	last_name,
	sex
FROM employees
WHERE first_name = 'Hercules' AND LEFT(last_name,1) = 'B';

--6.List each employee in the Sales department, including their employee number, last name, and first name.
SELECT
	emp_no,
	last_name,
	first_name
FROM employees AS emp
WHERE emp_no IN
	(
		SELECT de.emp_no
		FROM dept_emp AS de
		LEFT JOIN departments AS d ON de.dept_no = d.dept_no
		WHERE d.dept_name = 'Sales'
	); 


--7.List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT
	emp.emp_no,
	emp.last_name,
	emp.first_name,
	d.dept_name
FROM employees AS emp
LEFT JOIN dept_emp AS dept ON emp.emp_no = dept.emp_no
LEFT JOIN departments AS d ON dept.dept_no = d.dept_no
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development'
; 

--8.List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT
	last_name,
	COUNT(emp_no) AS num_of_emp
FROM employees
GROUP BY last_name
ORDER BY num_of_emp DESC;