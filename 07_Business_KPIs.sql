select * from Enterprise

--Business KPIs
--1) Total Transaction Amount
select SUM(Amount) [Total Amount] from Enterprise

--2) Total Numbers of Transaction
select COUNT(*) [Total Transaction] from Enterprise

--3) Total Successfull Transactions
select count(Status) [Success]
from Enterprise
where status='Success'

--4) Total Failed Transactions
select count(Status) [Failed]
from Enterprise
where status='Failed'

--5) Overall Success Rate
select
count(TransactionID) [Total Transaction],
sum(case 
        when Status='Success' then 1 
        else 0 
        end) [Total Successfull Transactions],
sum(case 
        when Status='Success' then 1 
        else 0 
        end)*100.0/count(TransactionID) [Success Rate]
from Enterprise

--6) Overall Failure Rate
select 
count(TransactionID) [Total Transacrtion],
sum(case 
        when Status='Failed' then 1 
        else 0 
        end) [Total Failed Transactions],
sum(case 
        when Status='Failed' then 1 
        else 0
        end)*100.0/COUNT(TransactionID) [Failure Rate]
from Enterprise

--7) Average Transaction Amount
select AVG(Amount) [Average Transaction Amount] from Enterprise

--8) Total Cashback Paid
select SUM(Cashback) [Total Cashback] from Enterprise

--9) Highest Transaction Amount
select MAX(Amount) [Highest Transaction Amount] from Enterprise

--10) Lowest Transaction Amount
select MIN(Amount) [Lowets Transaction Amount] from Enterprise











