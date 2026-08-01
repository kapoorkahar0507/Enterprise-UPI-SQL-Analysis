-- Date Analysis
--1) Daily Transaction Count
select Date,
COUNT(TransactionID) [Daily Transaction Count]
from Enterprise
group by date
order by date

--2) Daily Transaction Amount
select date,
cast(SUM(Amount) as decimal(10,2)) [Daily Transaction Amount]
from Enterprise
group by date
order by date

--3) Monthly Transaction Count
select 
      YEAR([Date]) as Year,
      MONTH([Date]) as Month,
COUNT(TransactionID) [Monthly Transaction]
from Enterprise
group by YEAR([Date]),MONTH([Date])
order by Year,Month

--4) Monthly Transaction Amount 
select 
      YEAR([Date]) as Year,
      MONTH([Date]) as Month,
cast(sum(Amount) as decimal(10,2)) [Monthly Transaction Amount]
from Enterprise
group by YEAR([Date]),MONTH([Date])
order by Year,Month

--5) Highest Revenue by Month
select top(1)
      YEAR([Date]) as Year,
      MONTH([Date]) as Month,
cast(sum(Amount) as decimal(10,2)) [Total Revenue]
from Enterprise
group by YEAR([Date]),MONTH([Date])
order by [Total Revenue] desc

-- or

select max([Monthly Transaction Amount]) as [Total Revenue]from
(select 
      YEAR([Date]) as Year,
      MONTH([Date]) as Month,
cast(sum(Amount) as decimal(10,2)) [Monthly Transaction Amount]
from Enterprise
group by YEAR([Date]),MONTH([Date])) k

--6) Lowest Revenue by Month
select top(1)
      YEAR([Date]) as Year,
      MONTH([Date]) as Month,
cast(sum(Amount) as decimal(10,2)) [Total Revenue]
from Enterprise
group by YEAR([Date]),MONTH([Date])
order by [Total Revenue] asc