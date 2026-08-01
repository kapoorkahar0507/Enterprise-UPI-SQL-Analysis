--Merchant  Analysis
--1) Revenue by Merchant
select Merchant,
round(sum(Amount),2) [Revenue]
from Enterprise
group by Merchant   
order by Revenue desc

--2) Transaction Count by Merchant
select Merchant,
count(*) [Number of Transaction]
from Enterprise
group by Merchant
order by count(*) desc

--3) Top 2 Merchant by Revenue
select top(2) Merchant,
ROUND(sum(Amount),2) [Revenue]
from Enterprise
group by Merchant
order by Revenue desc

--4) Lowest 2 Merchant by Revenue
select top(2) Merchant,
ROUND(sum(Amount),2) [Revenue]
from Enterprise
group by Merchant
order by Revenue asc

--5) Average Transaction Amount By Merchant
select Merchant,
round(AVG(Amount),2) [Average Transaction Amount]
from Enterprise
group by Merchant
order by [Average Transaction Amount] desc

--6) Cashback by Merchant
select Merchant,
SUM(Cashback) [Total Cashback]
from Enterprise
group by Merchant
order by [Total Cashback] desc

--7) Merchant Success Rate
select Merchant,
count(Status)[Total Transaction],
sum(case 
          when Status='Success' then 1 
          else 0 
          end) [Total Successfull Transactions],
round(sum(case 
          when Status='Success' then 1 
          else 0 
          end)*100.0/count(*),2) [Success Rate]
from Enterprise
group by Merchant

--8) Merchant Failure Rate
select Merchant,
count(*) [Total Transaction],
SUM(case
        when Status= 'Failed' then 1
        else 0
        end) [Total Failed Transactions],
round(SUM(case
        when Status= 'Failed' then 1
        else 0
        end)*100.0/count(*),2) [Failure Rate]
from Enterprise
group by Merchant
order by [Failure Rate] desc

--9) Top Merchant in Each Category
select Merchant,Category,
round(SUM(Amount),2) [Revenue]
from Enterprise
group by Merchant,Category

--10) Merchact Rank
select Merchant,
round(SUM(amount),2) [Revenue],
ROW_NUMBER() over(order by SUM(amount) desc) [Merchant Rank]
from Enterprise
group by Merchant