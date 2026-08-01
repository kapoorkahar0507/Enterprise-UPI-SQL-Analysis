--Advanced SQL Analysis
--1) Second highest transaction in each state
with SecondHigh as
(select State,Amount,
dense_rank() over(partition by state order by amount) [TR]
from Enterprise)

select * from SecondHigh
where [TR]=2

--2) Third highest spending customer
with ThirdHigh as
(select CustomerID,
round(sum(Amount),2)  [Spending Amount],
DENSE_RANK() over(order by sum(Amount) desc) [DR]
from Enterprise
group by CustomerID)

select * from ThirdHigh
where [DR]=3

--3) Running Total
select TransactionID,date,amount,
SUM(Amount) over(Order by date, TransactionID) [Running Total]
from Enterprise
order by date,TransactionID

--4) Previous transaction amount
select TransactionID,Date,Amount,
round(lag(amount) over(order by date),2) [Previous Transaction]
from Enterprise
order by date


--5) Next transaction amount
select CustomerID,Date,Amount,
round(lead(amount) over(order by date),2) [Previous Transaction]
from Enterprise
order by date

--6) First transaction 
select CustomerID,TransactionID,Date,Amount,
round(FIRST_VALUE(Amount) over(partition by customerid order by date,transactionid),2) [FirstTransaction]
from Enterprise
where CustomerID=1

--7) Last Transaction
select CustomerID,TransactionID,Date,Amount,
round(LAST_VALUE(Amount) over(partition by customerid order by date,transactionid 
rows between unbounded preceding and unbounded following),2) [Last Transaction]
from Enterprise
where CustomerID=1

--8) View for Successfull Transactions
create view Success_tr as(
select * from Enterprise
where Status='Success'
)

select * from Success_tr

--9) view for Failed Transaction
create view Failed_tr as(
select * from Enterprise
where Status='Failed'
)

select * from Failed_tr

--10) Stored Procedure For Monthly report
 create proc Monnthly_Report 
 --@Year int (if data more than one year) 
 as 
 begin
 select YEAR([Date]) as Year,
        MONTH([Date]) as Month,
        COUNT(TransactionID) [Numner of Transaction],
        round(sum(Amount),2) [Total Amount],
        round(avg(Amount),2) [Average Amount]
 from Enterprise
 group by YEAR([Date]),MONTH([Date])
 order by Month
 end

 Monnthly_Report

 exec Monnthly_Report

 execute Monnthly_Report