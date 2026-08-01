--Bank Analysis
--1) Total Number of Transactions By Bank
select Bank,
COUNT(*) [Number of Transactons]
from Enterprise
group by Bank
order by [Number of Transactons] desc

--2) Revenue by Bank
select Bank,
round(SUM(Amount),2) [Total Anount]
from Enterprise
group by bank
order by [Total Anount] desc

--3) Average Transaction Amount by Bank
select Bank,
round(AVG(Amount),2) [Average Transaction Amount]
from Enterprise
group by bank
order by [Average Transaction Amount] desc

--4) Success Rate by Bank
select Bank,
COUNT(*) [Total Number of Transactions],
SUM(case 
        when Status='Success' then 1 
        else 0 
        end) [Total Successfull Transactions],
sum(case 
        when Status='Success' then 1 
        else 0 
        end)*100/COUNT(*) [Success Rate]
from Enterprise
group by bank 
order by [Success Rate] desc

--5) Failure Rate by Bank
select Bank,
COUNT(*) [Total Number of Transactions],
SUM(case 
        when Status='Failed' then 1 
        else 0 
        end) [Total Failed Transactions],
sum(case 
        when Status='Failed' then 1 
        else 0 
        end)*100/COUNT(*) [Failure Rate]
from Enterprise
group by bank 
order by [Failure Rate] desc

--6) Cashback Paid by Bank 
select Bank,
SUM(Cashback) [Total Cashback]
from Enterprise
group by bank 
order by [Total Cashback] desc

--7) Rank Banks by Revenue
select Bank,round(sum(amount),2),
rank() over(order by sum(amount) desc) 
from Enterprise
group by bank

select Bank,round(sum(amount),2),
dense_rank() over(order by sum(amount) desc) 
from Enterprise
group by bank

select Bank,round(sum(amount),2),
row_number() over(order by sum(amount) desc) 
from Enterprise
group by bank

--8) Bank Market Share(%)
select bank,
round(SUM(Amount),2) [Total Amount],
round(SUM(Amount)*100/sum(sum(amount)) over(),2) [Market Share Percentage]
from Enterprise
group by Bank
order by [Market Share Percentage] desc

--9) Highest Revenue Bank Each Month
with Monthly_revenue as(
select 
YEAR([Date]) as Year,
MONTH([Date]) as Month,Bank,
round(SUM(Amount),2) [Total Amount],
ROW_NUMBER() over(partition by YEAR([Date]),MONTH([Date]) order by SUM(Amount) desc) [Row Number]
from Enterprise
group by YEAR([Date]),MONTH([Date]),Bank)
select * from Monthly_revenue
where [Row Number]=1
order by Year,Month

--10) Top 3Bank by Revenue
select top(3) Bank,
SUM(amount) [Total Amount],
DENSE_RANK() over(order by SUM(amount) desc) [DR]
from Enterprise
group by Bank
order by [Total Amount] desc

--Or

with BankRevenue as (
select Bank,
round(sum(Amount),2) [Total Amount],
DENSE_RANK() over(order by sum(Amount) desc) [Bank Rank]
from Enterprise
group by bank
)
select 
*
from BankRevenue
where [Bank Rank]<=3
