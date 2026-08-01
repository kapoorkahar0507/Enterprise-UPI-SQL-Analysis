--State & City Analysis
--1) Revenue by State
select State,
cast(SUM(Amount) as decimal(20,2)) [Total Amount]
from Enterprise
group by state
order by [Total Amount] desc

--2) Number of Transactions by State
select state,
COUNT(TransactionID) [Totat Transaction]
from Enterprise
group by state
order by COUNT(TransactionID) desc

--3) Top 2 State by Transaction Amount
select top(2) state,
cast(sum(Amount) as decimal(13,2)) as Total_Amount
from Enterprise
group by state 
order by Total_Amount desc

--4) Bottom 2 State by Transaction Amount
select top(2) state,
cast(sum(Amount) as decimal(13,2)) as Total_Amount
from Enterprise
group by state 
order by Total_Amount asc

--5) Revenue by City
select 
City,
cast(SUM(Amount) as decimal(15,2)) [Total Amiount]
from Enterprise
group by city
order by [Total Amiount] desc

--6) Top 2 Cities by Transaction Count
select top(2)
City,
COUNT(TransactionID) [Number of Transaction]
from Enterprise
group by City
order by COUNT(TransactionID) desc

--7) Average Transaction Amount by City
select
City,
cast(AVG(Amount) as decimal(10,2)) [Average Transaction Amount]
from Enterprise
group by City
order by AVG(Amount) desc

--8) Success Rate by State
select  state,
COUNT(*) [Total Transaction],
SUM(case
        when Status='Success' then 1
       else 0
       end) [Total Scuccessfull Transaction],
SUM(case 
        when Status ='Success' then 1
        else 0
        end)*100/COUNT(*) [Success Rate]
from Enterprise
group by State
order by [Success Rate] desc

/*SELECT
    State,
    COUNT(*) AS Total_Transactions,
    SUM(CASE
            WHEN Status = 'Success' THEN 1
            ELSE 0
        END) AS Successful_Transactions,
    ROUND(
        SUM(CASE
                WHEN Status = 'Success' THEN 1
                ELSE 0
            END) * 100.0 / COUNT(*),
        2
    ) AS Success_Rate
FROM Enterprise
GROUP BY State
ORDER BY Success_Rate DESC;*/

--9) Failure Rate by State
select state,
COUNT(*) [Total Number of Transaction],
SUM(case 
        when status='Failed' then 1
        else 0
end) [Total Failed Transaction],
sum(case
    when status='Failed' then 1
    else 0
end)*100/COUNT(*) [Failure Rate]
from Enterprise
group by State
order by [Failure Rate] desc 

--10) State wise Cashback Distribution
select state,
SUM(Cashback) [Total Cashback]
from Enterprise
group by state
order by SUM(Cashback) desc