CREATE TABLE "Departments" (
    "dept_no" VARCHAR(20)   NOT NULL,
    "dept_name" VARCHAR(30)   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "Department_Employees" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR(20)   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL,
    CONSTRAINT "pk_Department_Employees" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

CREATE TABLE "Department_Manager" (
    "dept_no" VARCHAR(20)   NOT NULL,
    "emp_no" INT   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL,
    CONSTRAINT "pk_Department_Manager" PRIMARY KEY (
        "dept_no","emp_no"
     )
);

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

CREATE TABLE "Salaries" (
    "emp_no" INT   NOT NULL,
    "salary" money   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL,
    CONSTRAINT "pk_Salaries" PRIMARY KEY (
        "emp_no","salary"
     )
);

CREATE TABLE "Titles" (
    "emp_no" INT   NOT NULL,
    "title" VARCHAR(30)   NOT NULL,
    "from_dat" DATE   NOT NULL,
    "to_date" DATE   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "emp_no","title", "from_dat"
     )
);

ALTER TABLE "Department_Employees" ADD CONSTRAINT "fk_Department_Employees_emp_no" FOREIGN KEY("emp_no")
REFERENCES "General_Employee_Information" ("emp_no");

ALTER TABLE "Department_Employees" ADD CONSTRAINT "fk_Department_Employees_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Department_Manager" ADD CONSTRAINT "fk_Department_Manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Department_Manager" ADD CONSTRAINT "fk_Department_Manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "General_Employee_Information" ("emp_no");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "General_Employee_Information" ("emp_no");

ALTER TABLE "Titles" ADD CONSTRAINT "fk_Titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "General_Employee_Information" ("emp_no");

SELECT * from "Departments";

SELECT * from "Department_Employees";

SELECT * from "General_Employee_Information";

SELECT * from "Department_Manager";

SELECT * from "Salaries";

SELECT * from "Titles";

SELECT i.emp_no, i.last_name, i.first_name, i.gender, s.salary
	FROM "General_Employee_Information" AS i
LEFT JOIN "Salaries" AS s
	ON i.emp_no = s.emp_no;

-- Finding Employees who were hired in 1986.
SELECT * from "General_Employee_Information" 
	WHERE (hire_date >= '1986-01-01' AND hire_date <= '1986-12-31');

-- Listing the Department of each Employeee.

SELECT i.emp_no, i.last_name, i.first_name, d.dept_name
	FROM "General_Employee_Information" AS i
LEFT JOIN "Department_Employees" AS de
	ON i.emp_no = de.emp_no
LEFT JOIN "Departments" AS d 
	ON de.dept_no = d.dept_no;




