CREATE TABLE "departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INTEGER   NOT NULL,
    "dept_no" VARCHAR   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INTEGER   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" INTEGER   NOT NULL,
    "emp_title_id" VARCHAR   NOT NULL,
    "birth_date" VARCHAR   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "sex" VARCHAR   NOT NULL,
    "hire_date" VARCHAR   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);


CREATE TABLE "salaries" (
    "emp_no" INTEGER   NOT NULL,
    "salary" INTEGER   NOT NULL
);

CREATE TABLE "titles" (
    "title_id" VARCHAR   NOT NULL,
    "title" VARCHAR   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);


ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager__dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager__emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries__emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary.
select e.emp_no,e.last_name, e.first_name,s.salary
from employees as e
inner join salaries as s
	on e.emp_no = s.emp_no;

-- 2. List first name, last name, and hire date for employees who were hired in 1986.
select first_name, last_name, hire_date
from employees
where (hire_date) like '%1986';

-- 3.List the manager of each department with the following information: 
-- department number, department name, the manager's employee number, last name, first name.
select d.dept_no, departments.dept_name, d.emp_no, e.last_name, e.first_name
from departments
inner join dept_manager as d ON d.dept_no= departments.dept_no
inner join employees as e ON e.emp_no= d.emp_no;

-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.
select e.emp_no,e.last_name, e.first_name, departments.dept_name
from employees as e
inner join dept_emp as d on e.emp_no = d.emp_no
inner join departments on departments.dept_no = d.dept_no;

-- 5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
select first_name, last_name, sex
from employees
where first_name = 'Hercules' and (Last_Name) like 'B%';

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
select e.emp_no,e.last_name, e.first_name, departments.dept_name
from employees as e
inner join dept_emp as d on e.emp_no = d.emp_no
inner join departments on departments.dept_no = d.dept_no
where dept_name = 'Sales';

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
select e.emp_no,e.last_name, e.first_name, departments.dept_name
from employees as e
inner join dept_emp as d on e.emp_no = d.emp_no
inner join departments on departments.dept_no = d.dept_no
where dept_name = 'Sales' or dept_name = 'Development';

-- 8.In descending order, list the frequency count of employee last names, i.e., how many employees share each last name
select last_name, count(last_name) as "Last Name Count"
from employees
group by last_name
order by "Last Name Count" desc;
