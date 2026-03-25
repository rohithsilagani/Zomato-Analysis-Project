create database salespeople;


CREATE TABLE salespeople (
    snum INT PRIMARY KEY,
    sname VARCHAR(50),
    city VARCHAR(50),
    comm DECIMAL(4,2)
);

INSERT INTO salespeople (snum, sname, city, comm) VALUES
(1001, 'Peel', 'London', 0.12),
(1002, 'Serres', 'San Jose', 0.13),
(1003, 'Axelrod', 'New York', 0.10),
(1004, 'Motika', 'London', 0.11),
(1007, 'Rafkin', 'Barcelona', 0.15);

SELECT * FROM salespeople;

CREATE TABLE customers (
    cnum INT PRIMARY KEY,
    cname VARCHAR(50),
    city VARCHAR(50),
    rating INT,
    snum INT
);

INSERT INTO customers (cnum, cname, city, rating, snum) VALUES
(2001, 'Hoffman', 'London', 100, 1001),
(2002, 'Giovanne', 'Rome', 200, 1003),
(2003, 'Liu', 'San Jose', 300, 1002),
(2004, 'Grass', 'Berlin', 100, 1002),
(2006, 'Clemens', 'London', 300, 1007),
(2007, 'Pereira', 'Rome', 100, 1004),
(2008, 'James', 'London', 200, 1007);

SELECT * FROM customers;

CREATE TABLE orders (
    onum INT PRIMARY KEY,
    amt DECIMAL(10,2),
    odate DATE,
    cnum INT,
    snum INT
);

INSERT INTO orders (onum, amt, odate, cnum, snum) VALUES
(3001, 18.69,  '1994-10-03', 2008, 1007),
(3002, 1900.10,'1994-10-03', 2007, 1004),
(3003, 767.19, '1994-10-03', 2001, 1001),
(3005, 5160.45,'1994-10-03', 2003, 1002),
(3006, 1098.16,'1994-10-04', 2008, 1007),
(3007, 75.75,  '1994-10-05', 2004, 1002),
(3008, 4723.00,'1994-10-05', 2006, 1001),
(3009, 1713.23,'1994-10-04', 2002, 1003),
(3010, 1309.95,'1994-10-06', 2004, 1002),
(3011, 9891.88,'1994-10-06', 2006, 1001);

SELECT * FROM orders;

SELECT 
    s.sname AS salesperson_name,
    c.cname AS customer_name,
    s.city
FROM salespeople s
JOIN customers c
ON s.city = c.city;

SELECT 
    c.cname AS customer_name,
    s.sname AS salesperson_name
FROM customers c
JOIN salespeople s
ON c.snum = s.snum;

SELECT 
    o.onum,o.amt,o.odate,
    c.cname AS customer_name,
    c.city  AS customer_city,
    s.sname AS salesperson_name,
    s.city  AS salesperson_city
FROM orders o JOIN customers c
 ON o.cnum = c.cnum
JOIN salespeople s
    ON o.snum = s.snum
WHERE c.city <> s.city;

SELECT 
    o.onum AS order_number,
    c.cname AS customer_name
FROM orders o
JOIN customers c
ON o.cnum = c.cnum;

SELECT 
    c1.cname AS customer1,
    c2.cname AS customer2,
    c1.rating
FROM customers c1
JOIN customers c2
ON c1.rating = c2.rating
AND c1.cnum < c2.cnum;

SELECT 
    c1.cname AS customer1,
    c2.cname AS customer2,
    c1.snum  AS salesperson_no
FROM customers c1
JOIN customers c2
ON c1.snum = c2.snum
AND c1.cnum < c2.cnum;

SELECT 
    s1.sname AS salesperson1,
    s2.sname AS salesperson2,
    s1.city
FROM salespeople s1
JOIN salespeople s2
ON s1.city = s2.city
AND s1.snum < s2.snum;

SELECT * 
FROM orders
WHERE snum = (
    SELECT DISTINCT snum
    FROM orders
    WHERE cnum= 2008
    LIMIT 1
);

select * from salespeople;
select * from customers;

select * from orders where 
snum = ( select snum from customers where cnum = 2008);

select * from orders;
select * from orders where 
amt > (select avg(amt) from orders where odate = "1994-10-04");

select * from salespeople;

select * from orders where 
snum in ( select snum from salespeople where city="london");

select * from customers;

select * from salespeople;
select * from customers where
 cnum > ( select snum + 1000 from salespeople where sname = "serres");

 select * from customers;
 select count(*) from customers where 
 rating > ( select avg(rating) from customers where city = "san jose"); 
 
select * from salespeople;
select * from customers;
SELECT snum, COUNT(cnum) AS customer_count
FROM customers
GROUP BY snum
HAVING COUNT(cnum) > 1;
 

CREATE TABLE Employee (
    empno   INT NOT NULL,
    ename   VARCHAR(20),
    job     VARCHAR(20) DEFAULT 'CLERK',
    mgr     INT,
    hiredate DATE,
    sal     DECIMAL(10,2) CHECK (sal > 0),
    comm    DECIMAL(10,2),
    deptno  INT,

    CONSTRAINT pk_emp PRIMARY KEY (empno),
    CONSTRAINT fk_dept FOREIGN KEY (deptno)
        REFERENCES Dept(deptno)
);
INSERT INTO Employee VALUES (7369, 'SMITH', 'CLERK', 7902, '1890-12-17', 800.00, NULL, 20);

INSERT INTO Employee VALUES (7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600.00, 300.00, 30);

INSERT INTO Employee VALUES (7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250.00, 500.00, 30);

INSERT INTO Employee VALUES (7566, 'JONES', 'MANAGER', 7839, '1981-04-02', 2975.00, NULL, 20);

INSERT INTO Employee VALUES (7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250.00, 1400.00, 30);

INSERT INTO Employee VALUES (7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850.00, NULL, 30);

INSERT INTO Employee VALUES (7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450.00, NULL, 10);

INSERT INTO Employee VALUES (7788, 'SCOTT', 'ANALYST', 7566, '1987-04-19', 3000.00, NULL, 20);

INSERT INTO Employee VALUES (7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000.00, NULL, 10);

INSERT INTO Employee VALUES (7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08', 1500.00, 0.00, 30);

INSERT INTO Employee VALUES (7876, 'ADAMS', 'CLERK', 7788, '1987-05-23', 1100.00, NULL, 20);

INSERT INTO Employee VALUES (7900, 'JAMES', 'CLERK', 7698, '1981-12-03', 950.00, NULL, 30);

INSERT INTO Employee VALUES (7902, 'FORD', 'ANALYST', 7566, '1981-12-03', 3000.00, NULL, 20);

INSERT INTO Employee VALUES (7934, 'MILLER', 'CLERK', 7782, '1982-01-23', 1300.00, NULL, 10);


SELECT * FROM EMPLOYEE;




Create table dept (deptno int PRIMARY KEY, dname varchar(20),loc varchar (20));
insert into dept (deptno, dname, loc) values 
(10, "operations", "BOSTON"),
(20, "RESEARCH", "DALLAS"),
(30, "SALES", "CHICAGO"),
(40, "ACCOUNTING", "NEW YORK");

SELECT ENAME AS EMP_NAME, SAL AS SALARY FROM EMPLOYEE WHERE SAL > 1000;




SELECT * FROM EMPLOYEE 
WHERE (HIREDATE)<="1981-09-29";

SELECT ENAME FROM EMPLOYEE 
WHERE ENAME LIKE "_I%";

SELECT 
    ename AS Employee_Name,
    sal   AS Salary,
    sal * 0.40 AS Allowances,
    sal * 0.10 AS PF,
    sal + (sal * 0.40) - (sal * 0.10) AS Net_Salary
FROM Employee;

SELECT ENAME AS EMPLOYEE, 
JOB AS DESIGNATION FROM EMPLOYEE WHERE MGR IS NULL;


SELECT EMPNO,ENAME,SAL 
FROM EMPLOYEE ORDER BY SAL ASC;



SELECT COUNT(distinct job) AS total_job FROM employee;



SELECT * from employee;

SELECT SUM(sal) AS total_payable_salary
FROM employee
WHERE job = 'SALESMAN';


SELECT deptno, job, AVG(sal) AS avg_monthly_salary
FROM employee
GROUP BY deptno, job;


SELECT 
    e.ename AS empname,
    e.sal   AS salary,
    d.dname AS deptname
FROM employee e
JOIN dept d
ON e.deptno = d.deptno;


CREATE TABLE job_grades (
    grade CHAR(1) PRIMARY KEY,
    lowest_sal INT,
    highest_sal INT
);


INSERT INTO job_grades VALUES ('A', 0, 999);

INSERT INTO job_grades VALUES ('B', 1000, 1999);

INSERT INTO job_grades VALUES ('C', 2000, 2999);

INSERT INTO job_grades VALUES ('D', 3000, 3999);

INSERT INTO job_grades VALUES ('E', 4000, 5000);


SELECT * FROM job_grades;


SELECT 
    e.ename AS last_name,
    e.sal AS salary,
    j.grade AS grade
FROM employee e
JOIN job_grades j
ON e.sal BETWEEN j.lowest_sal AND j.highest_sal;


SELECT 	
    e.ename AS Emp,
    'Report to' AS Reports_To, 
	m.ename AS Mgr
FROM employee e
JOIN employee m
ON e.mgr = m.empno;

SELECT ename, sal, comm FROM employee;


SELECT 
    ename AS Empname,
    sal + IFNULL(comm, 0) AS Total_Sal
FROM employee;


SELECT 
    ename AS Empname,
    sal
FROM employee
WHERE MOD(empno, 2) = 1;


SELECT 
    ename AS Empname,
    RANK() OVER (ORDER BY sal DESC) AS Org_Sal_Rank,
    RANK() OVER (PARTITION BY deptno ORDER BY sal DESC) AS Dept_Sal_Rank
FROM employee;


SELECT ename AS Empname
FROM employee
ORDER BY sal DESC
LIMIT 3;


SELECT ename AS Empname
FROM employee e
WHERE sal = (
     SELECT MAX(sal)
     FROM employee
     WHERE deptno = e.deptno
);
