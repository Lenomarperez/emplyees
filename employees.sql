CREATE TABLE employees (
  emp_no INT,
  emp_title VARCHAR(30) NOT NULL,
  birth_date Date,
  first_name VARCHAR(30),
  last_name VARCHAR(30),
  sex VARCHAR(1),
  hire_date DATE
);

CREATE TABLE dept_employees(
  emp_no INT,
  dept_no VARCHAR(30)
  
);

CREATE TABLE department(
  dept_no VARCHAR(30),
  dept_name VARCHAR(30)
);

CREATE TABLE dept_manager(
  dept_no VARCHAR(30),
  emp_no INT
);

CREATE TABLE salaries(
  emp_no INT,
  salary INT
);

CREATE TABLE titles (
  title_id VARCHAR,
  titles VARCHAR
);


---List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

---List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT 
  department.dept_no,
  department.dept_name,
  dept_manager.emp_no AS manager_emp_no,
  employees.last_name AS manager_last_name,
  employees.first_name AS manager_first_name
FROM department
INNER JOIN dept_manager
  ON department.dept_no = dept_manager.dept_no
INNER JOIN employees
  ON dept_manager.emp_no = employees.emp_no;

---(orderby emp_no)List the employee number, last name, first name, sex, and salary of each employee.  
SELECT 
  employees.emp_no, 
  employees.last_name, 
  employees.first_name, 
  employees.sex, 
  salaries.salary
FROM employees
INNER JOIN salaries
  ON employees.emp_no = salaries.emp_no;
  
----***List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT 
  employees.emp_no, 
  employees.last_name, 
  employees.first_name, 
  department.dept_name, 
  dept_employees.dept_no
FROM employees
INNER JOIN dept_employees
  ON employees.emp_no = dept_employees.emp_no
INNER JOIN department
  ON dept_employees.dept_no = department.dept_no;
----List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT 
  first_name,
  last_name,
  sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-----***List each employee in the Sales department, including their employee number, last name, and first name.
SELECT 
  employees.emp_no,
  employees.last_name,
  employees.first_name
FROM employees
INNER JOIN dept_employees
  ON employees.emp_no = dept_employees.emp_no
INNER JOIN department
  ON dept_employees.dept_no = department.dept_no
WHERE department.dept_name = 'Sales';
---***List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT 
  employees.emp_no,
  employees.last_name,
  employees.first_name,
  department.dept_name
FROM employees
INNER JOIN dept_employees
  ON employees.emp_no = dept_employees.emp_no
INNER JOIN department
  ON dept_employees.dept_no = department.dept_no
WHERE department.dept_name IN ('Sales', 'Development');
-----List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT 
  employees.last_name,
  COUNT(*) as frequency
FROM employees
GROUP BY employees.last_name
ORDER BY frequency DESC;

