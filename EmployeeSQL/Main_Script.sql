-- creating Departments table framework.
CREATE TABLE "Departments" (
    "dept_no" VARCHAR(20)   NOT NULL,
    "dept_name" VARCHAR(30)   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_no"
     )
);

-- Creating Department employees framework.
CREATE TABLE "Department_Employees" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR(20)   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL,
    CONSTRAINT "pk_Department_Employees" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

-- creating Department Manager framework.
CREATE TABLE "Department_Manager" (
    "dept_no" VARCHAR(20)   NOT NULL,
    "emp_no" INT   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL,
    CONSTRAINT "pk_Department_Manager" PRIMARY KEY (
        "dept_no","emp_no"
     )
);

-- creating General Employee Information framework.
CREATE TABLE "General_Employee_Information" (
    "emp_no" INT   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR(30)   NOT NULL,
    "last_name" VARCHAR(30)   NOT NULL,
    "gender" VARCHAR(1)   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_General_Employee_Information" PRIMARY KEY (
        "emp_no"
     )
);

-- creating salaries framework.
CREATE TABLE "Salaries" (
    "emp_no" INT   NOT NULL,
    "salary" money   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL,
    CONSTRAINT "pk_Salaries" PRIMARY KEY (
        "emp_no","salary"
     )
);

-- creating titles framework.
CREATE TABLE "Titles" (
    "emp_no" INT   NOT NULL,
    "title" VARCHAR(30)   NOT NULL,
    "from_dat" DATE   NOT NULL,
    "to_date" DATE   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "emp_no","title", "from_dat"
     )
);

-- adding foreign key to Department Employees framework.
ALTER TABLE "Department_Employees" ADD CONSTRAINT "fk_Department_Employees_emp_no" FOREIGN KEY("emp_no")
REFERENCES "General_Employee_Information" ("emp_no");

-- adding foreign key to Department Employees framework. 
ALTER TABLE "Department_Employees" ADD CONSTRAINT "fk_Department_Employees_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

-- adding foreign key to Department Manager framework.
ALTER TABLE "Department_Manager" ADD CONSTRAINT "fk_Department_Manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

-- adding another foreign key to Department Manager framework.
ALTER TABLE "Department_Manager" ADD CONSTRAINT "fk_Department_Manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "General_Employee_Information" ("emp_no");

-- adding foreign key to Salaries framework.
ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "General_Employee_Information" ("emp_no");

-- adding foreign key to Titles framework.
ALTER TABLE "Titles" ADD CONSTRAINT "fk_Titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "General_Employee_Information" ("emp_no");

-- verifing results.
SELECT * from "Departments";

-- verifing results.
SELECT * from "Department_Employees";

-- verifing results.
SELECT * from "General_Employee_Information";

-- verifing results.
SELECT * from "Department_Manager";

-- verifing results.
SELECT * from "Salaries";

-- verifing results.
SELECT * from "Titles";

-- merging the General_Employee_Information table with the Salaries table on emp_no.
SELECT i.emp_no, i.last_name, i.first_name, i.gender, s.salary
	FROM "General_Employee_Information" AS i
LEFT JOIN "Salaries" AS s
	ON i.emp_no = s.emp_no;

-- Finding Employees who were hired in 1986 using a conditional statement on the General_Employee_Information table.
SELECT * from "General_Employee_Information" 
	WHERE (hire_date >= '1986-01-01' AND hire_date <= '1986-12-31');

-- Listing the Department of each Employeee.
SELECT i.emp_no, i.last_name, i.first_name, d.dept_name
	FROM "General_Employee_Information" AS i
LEFT JOIN "Department_Employees" AS de
	ON i.emp_no = de.emp_no
LEFT JOIN "Departments" AS d 
	ON de.dept_no = d.dept_no
ORDER BY emp_no;

-- Finding employees with first name Hercules and last name that starts with B.
SELECT * from  "General_Employee_Information" 
	WHERE first_name = 'Hercules' AND last_name LiKE 'B%';

-- Finding all employees in the Sales Department by joining the General_Employee_Information and Deparment_Employee table and then filtering by dep_name = Sales.
SELECT i.emp_no, i.last_name, i.first_name, d.dept_name
	FROM "General_Employee_Information" AS i
LEFT JOIN "Department_Employees" AS de
	ON i.emp_no = de.emp_no
LEFT JOIN "Departments" AS d 
	ON de.dept_no = d.dept_no
WHERE dept_name = 'Sales'
	ORDER BY emp_no;
	
-- Listing all employees in the Sales and Development departments, including their employee number, last name, first name, and department name by using same method above but adding Development into the filter.
SELECT i.emp_no, i.last_name, i.first_name, d.dept_name
	FROM "General_Employee_Information" AS i
LEFT JOIN "Department_Employees" AS de
	ON i.emp_no = de.emp_no
LEFT JOIN "Departments" AS d 
	ON de.dept_no = d.dept_no
WHERE dept_name = 'Sales' OR dept_name = 'Development'
	ORDER BY emp_no;
	



-- In descending order, listing the frequency count of employee last names, i.e., how many employees share each last name applying a groupby on General_Employee_Information.
SELECT last_name, Count(*) AS CNT
	FROM "General_Employee_Information"
GROUP BY last_name
	HAVING COUNT(*) >= 1
ORDER BY CNT DESC;

