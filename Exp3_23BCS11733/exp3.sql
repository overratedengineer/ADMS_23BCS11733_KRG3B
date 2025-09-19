-- easy question

CREATE TABLE EMPLOYEE (
    EMPID INT
);

INSERT INTO EMPLOYEE VALUES (1),(2),(3),(2),(4),(6),(6),(7),(7);

SELECT * FROM EMPLOYEE;

SELECT MAX(EMPID) AS MaxUniqueEmpID
FROM EMPLOYEE
WHERE EMPID NOT IN (
    SELECT EMPID
    FROM EMPLOYEE
    GROUP BY EMPID
    HAVING COUNT(EMPID) > 1
);

-- medium question

CREATE TABLE dept (
    id INT PRIMARY KEY,
    Dept_Name VARCHAR(50) NOT NULL
);

CREATE TABLE employee (
    id INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Salary INT,
    Dept_Id INT FOREIGN KEY REFERENCES dept(id)
);

INSERT INTO dept VALUES (1, 'IT'), (2, 'SALES');

INSERT INTO employee VALUES
(1, 'JOE', 70000, 1),
(2, 'JIM', 90000, 1),
(3, 'HENRY', 80000, 2),
(4, 'SAM', 60000, 2),
(5, 'MAX', 90000, 1);

-- Get top earners in each department
SELECT D.Dept_Name, E.EmpName, E.Salary
FROM employee AS E
INNER JOIN dept AS D
    ON E.Dept_Id = D.id
WHERE E.Salary IN (
    SELECT MAX(E2.Salary)
    FROM employee AS E2
    WHERE E2.Dept_Id = E.Dept_Id
);


-- hard question

CREATE TABLE TableA (
    Empid INT,
    Ename VARCHAR(50),
    Salary INT
);

CREATE TABLE TableB (
    Empid INT,
    Ename VARCHAR(50),
    Salary INT
);

INSERT INTO TableA VALUES (1, 'AA', 1000), (2, 'BB', 300);
INSERT INTO TableB VALUES (2, 'BB', 400), (3, 'CC', 100);

-- Find each employee with minimum salary across both tables
SELECT Empid, Ename, MIN(Salary) AS LowestSalary
FROM (
    SELECT Empid, Ename, Salary FROM TableA
    UNION ALL
    SELECT Empid, Ename, Salary FROM TableB
) AS Combined
GROUP BY Empid, Ename;
