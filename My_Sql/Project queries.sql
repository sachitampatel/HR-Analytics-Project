

CREATE DATABASE hr_analytics;
USE hr_analytics;
CREATE TABLE Employee_Details (
    EmployeeNumber INT PRIMARY KEY,
    Age INT,
    Attrition VARCHAR(10),
    BusinessTravel VARCHAR(50),
    DailyRate INT,
    Department VARCHAR(50),
    DistanceFromHome INT,
    Education INT,
    EducationField VARCHAR(50),
    EmployeeCount INT,
    EnvironmentSatisfaction INT,
    Gender VARCHAR(10),
    HourlyRate INT,
    JobInvolvement INT,
    JobLevel INT,
    JobRole VARCHAR(50),
    JobSatisfaction INT,
    MaritalStatus VARCHAR(20)
);

CREATE TABLE Employee_Salary (
    EmployeeID INT PRIMARY KEY,
    MonthlyIncome INT,
    MonthlyRate INT,
    NumCompaniesWorked INT,
    Over18 VARCHAR(5),
    OverTime VARCHAR(5),
    PercentSalaryHike INT,
    PerformanceRating INT,
    RelationshipSatisfaction INT,
    StandardHours INT,
    StockOptionLevel INT,
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance INT,
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT
);

select * from employee_details;
select * from employee_salary;

select * from employee_details ed join employee_salary es on ed.employeenumber=es.employeeid;

-- 1) Average Attrition Rate for all department
select department, count(case when attrition="yes" then 1 end)*100/count(*) as attritionrate from employee_details group by department;

-- 2) Average hourly rate of male research scientists
select avg(Hourlyrate) as avghourlyrate from employee_details where gender="male" and jobrole="research scientist";

-- 3) Attrition rate vs monthly income stats
select case when monthlyincome<5000 then "low income" when monthlyincome between 5000 and 15000 then "mid income" else "high income" end as incomecategory, count(case when attrition="yes" then 1 end)*100/count(*) as attritionrate from employee_details ed join employee_salary on ed.employeenumber=employee_salary.employeeid group by incomecategory;

-- 4) Average working years for each department
select ed.department,avg(es.totalworkingyears) as avgworkingyears from employee_details ed join employee_salary es on ed.employeenumber=es.employeeid group by ed.department;

-- 5) jobrole vs worklifebalance
select ed.jobrole, avg(worklifebalance) as avgworklifebalance from employee_details ed join employee_salary es on ed.employeenumber=es.employeeid group by ed.jobrole;

-- 6) Attrition rate vs years since last promotion
select es.yearssincelastpromotion,count(case when ed.attrition="yes"then 1 end)*100/count(*) as attritionrate from employee_details ed join employee_salary es on ed.employeenumber=es.employeeid group by es.yearssincelastpromotion order by es.yearssincelastpromotion;