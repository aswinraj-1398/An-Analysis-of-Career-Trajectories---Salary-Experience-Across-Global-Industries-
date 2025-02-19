SELECT * FROM survay_salary.milestone_project_cleaned;
Use Survay_salary;

SELECT DISTINCT Gender
FROM milestone_project_cleaned;

/*a*/

SELECT 
    Industry,
    Gender,
    AVG(Annual_Salary) AS Average_Salary
FROM 
    milestone_project_cleaned
GROUP BY 
    Industry, Gender
ORDER BY 
    Industry, Gender;

/*b*/

SELECT 
    Job_Title,
    SUM(Annual_Salary + Additional_Monetary_Compensation) AS Total_Compensation
FROM 
    milestone_project_cleaned
GROUP BY 
    Job_Title
ORDER BY 
    Total_Compensation DESC;

/*c*/
  
    SELECT 
    Highest_Education,
    AVG(Annual_Salary) AS Average_Salary,
    MIN(Annual_Salary) AS Minimum_Salary,
    MAX(Annual_Salary) AS Maximum_Salary
FROM 
    milestone_project_cleaned
GROUP BY 
    Highest_Education
ORDER BY 
    Highest_Education;

/*d*/

SELECT 
    Industry,
    `Total _Years_of _Professional_Experience`,
    COUNT(*) AS Number_of_Employees
FROM 
    milestone_project_cleaned
GROUP BY 
    Industry, `Total _Years_of _Professional_Experience`
ORDER BY 
    Industry, `Total _Years_of _Professional_Experience`;

/*e*/

SELECT 
    Age_Range,
    Gender,
    AVG(Annual_Salary) AS Median_Salary
FROM (
    SELECT 
        Age_Range,
        Gender,
        Annual_Salary,
        @row_num := @row_num + 1 AS row_num,
        @total_rows := @row_num
    FROM 
        milestone_project_cleaned, 
        (SELECT @row_num := 0) AS init
    ORDER BY 
        Age_Range, Gender, Annual_Salary
) AS sorted_salaries
WHERE 
    row_num IN (FLOOR(@total_rows / 2), FLOOR(@total_rows / 2) + 1)
GROUP BY 
    Age_Range, Gender;
    
    
   SELECT 
    distinct Gender,
    AVG(Annual_Salary) AS Median_Salary
FROM (
    SELECT 
        distinct Gender,
        Annual_Salary,
        @row_num := @row_num + 1 AS row_num,
        @total_rows := @row_num
    FROM 
        milestone_project_cleaned,
        (SELECT @row_num := 0) AS init
    WHERE Gender IS NOT NULL
    ORDER BY 
        Gender, Annual_Salary
) AS sorted_salaries
WHERE 
    row_num BETWEEN FLOOR(@total_rows / 2) AND FLOOR(@total_rows / 2) + 1
GROUP BY 
    Gender;

   


/*f*/

SELECT 
    Country,
    Job_Title,
    MAX(Annual_Salary) AS Highest_Salary
FROM 
    milestone_project_cleaned
GROUP BY 
    Country, Job_Title
ORDER BY 
    Country, Highest_Salary DESC;

/*g*/

SELECT 
    City,
    Industry,
    AVG(Annual_Salary) AS Average_Salary
FROM 
    milestone_project_cleaned
GROUP BY 
    City, Industry
ORDER BY 
    City, Average_Salary DESC;
    
    /*h*/

SELECT 
    Gender,
    ROUND(
        (SUM(CASE WHEN Additional_Monetary_Compensation > 0 THEN 1 ELSE 0 END) 
        / COUNT(*)) * 100, 2
    ) AS Percentage_With_Additional_Compensation
FROM 
    milestone_project_cleaned
GROUP BY 
    Gender;

/*i*/

SELECT 
    Job_Title,
    `Total _Years_of _Professional_Experience`,
    SUM(Annual_Salary + Additional_Monetary_Compensation) AS Total_Compensation
FROM 
    milestone_project_cleaned
GROUP BY 
    Job_Title, `Total _Years_of _Professional_Experience`
ORDER BY 
    Total_Compensation DESC;

/*j*/

SELECT 
    Industry,
    Gender,
    Highest_Education,
    AVG(Annual_Salary) AS Average_Salary
FROM 
    milestone_project_cleaned
GROUP BY 
    Industry, Gender, Highest_Education
ORDER BY 
    Industry, Gender, Highest_Education;
