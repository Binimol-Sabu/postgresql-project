CREATE TABLE finance_data (
    Income NUMERIC,
    Age INT,
    Dependents INT,
    Occupation VARCHAR,
    City_Tier VARCHAR,
    Rent NUMERIC,
    Loan_Repayment NUMERIC,
    Insurance NUMERIC,
    Groceries NUMERIC,
    Transport NUMERIC,
    Eating_Out NUMERIC,
    Entertainment NUMERIC,
    Utilities NUMERIC,
    Healthcare NUMERIC,
    Education NUMERIC,
    Miscellaneous NUMERIC,
    Desired_Savings_Percentage NUMERIC,
    Desired_Savings NUMERIC,
    Disposable_Income NUMERIC,
    Potential_Savings_Groceries NUMERIC,
    Potential_Savings_Transport NUMERIC,
    Potential_Savings_Eating_Out NUMERIC,
    Potential_Savings_Entertainment NUMERIC,
    Potential_Savings_Utilities NUMERIC,
    Potential_Savings_Healthcare NUMERIC,
    Potential_Savings_Education NUMERIC,
    Potential_Savings_Miscellaneous NUMERIC
);
SELECT COUNT(*)FROM finance_data;

SELECT * FROM finance_data
LIMIT 10;

SELECT * FROM finance_data
WHERE income IS NULL
OR age IS NULL
OR dependents IS NULL
OR occupation IS NULL
OR city_tier IS NULL
OR rent IS NULL
OR loan_repayment IS NULL;

--> List people who spend more than ₹10,000 on groceries.
SELECT * FROM finance_data
WHERE Groceries>10000;
--> Individuals with income above average.
SELECT *
FROM finance_data
WHERE Income > (SELECT AVG(Income) FROM finance_data);
--> Average spending by Occupation.
SELECT Occupation,
       AVG(Groceries) AS avg_groceries,
       AVG(Transport) AS avg_transport,
       AVG(Rent) AS avg_rent,
       AVG(Healthcare) AS avg_healthcare
FROM finance_data
GROUP BY Occupation;
--> Total rent paid in each City_Tier
SELECT City_Tier,
       SUM(Rent) AS total_rent
FROM finance_data
GROUP BY City_Tier;
--> Sum of Desired_Savings grouped by Age.
SELECT Age,
       SUM(Desired_Savings) AS total_savings
FROM finance_data
GROUP BY Age
ORDER BY Age;
--> Average Loan_Repayment by occupation
SELECT occupation,
       AVG(loan_repayment) as avg_loan_repayment
From finance_data
GROUP BY occupation;
--> Rank individuals based on their Disposable_Income.
SELECT *,
       RANK() OVER (ORDER BY Disposable_Income DESC) AS income_rank
FROM finance_data
LIMIT 10;
-->Calculate cumulative expenses (Groceries + Rent + Transport...) per individual
SELECT *,
       (Groceries + Rent + Transport + Insurance + Eating_Out +
        Entertainment + Utilities + Healthcare + Education + Miscellaneous) AS total_expense
FROM finance_data
ORDER BY total_expense DESC
limit 10;
-->Segment users based on Desired_Savings_Percentage
SELECT *,
       CASE
           WHEN Desired_Savings_Percentage >= 15 THEN 'High Saver'
           WHEN Desired_Savings_Percentage BETWEEN 8 AND 15 THEN 'Moderate Saver'
           ELSE 'Low Saver'
       END AS savings_segment
FROM finance_data;

--> how many High Savers belong to each occupation
SELECT Occupation,
       COUNT(*) AS high_saver_count
FROM finance_data
WHERE Desired_Savings_Percentage >= 15
GROUP BY Occupation
ORDER BY high_saver_count DESC;
-->Analyze how expenses and savings patterns change with age
SELECT Age,
       AVG(Income) AS avg_income,
       AVG(Desired_Savings) AS avg_savings,
       AVG(Loan_Repayment) AS avg_loan
FROM finance_data
GROUP BY Age
ORDER BY Age;

-->Total Expenses by Number of Dependents
SELECT Dependents,
       SUM(Groceries + Rent + Transport + Insurance + Eating_Out +
           Entertainment + Utilities + Healthcare + Education + Miscellaneous) AS total_expense
FROM finance_data
GROUP BY Dependents
ORDER BY Dependents;

--->Overspending Analysis
SELECT *,
       (Groceries + Rent + Transport + Insurance + Eating_Out +
        Entertainment + Utilities + Healthcare + Education + Miscellaneous - Income) AS overspending
FROM finance_data
WHERE (Groceries + Rent + Transport + Insurance + Eating_Out +
       Entertainment + Utilities + Healthcare + Education + Miscellaneous - Income) > 0;

SELECT COUNT(*)
FROM finance_data
WHERE (Groceries + Rent + Transport + Insurance + Eating_Out +
       Entertainment + Utilities + Healthcare + Education + Miscellaneous) > Income;

