--Customer Analysis
--1)Total Unique Customers
select 
distinct CustomerID
from Enterprise
order by CustomerID

--2) Top 20 Customers by Spending 
select top(20) CustomerID,
round(SUM(Amount),2) Amount 
from Enterprise
group by CustomerID
order by Amount desc

--3) Average Spending Per Customer
select CustomerID,
round(AVG(Amount),2) [Average Spending Amount]
from Enterprise
group by CustomerID
order by AVG(Amount) desc 

--4) Highest Cashbak Recived by Customers
with HighCashback as
(select CustomerID,Cashback,
DENSE_RANK() over(order by cashback desc) [Highest Cashback]
from Enterprise)

select * from HighCashback
where [Highest Cashback]=1

--5) Customers with more then 30 Transactions
select CustomerID, 
count(TransactionID) [Number of Transactions]
from Enterprise
group by CustomerID
having count(TransactionID)>=30

--6) One time Customers
select CustomerID,
COUNT(TransactionID) [Number of Transactions]
from Enterprise
group by CustomerID
having COUNT(TransactionID)=1

--7) Customer Lifetime Value
select CustomerID,
COUNT(TransactionID) [Number of Transactions],
round(SUM(Amount),2) [CLV]
from Enterprise
group by CustomerID
order by [CLV] desc

--8) First Transaction of every customer.
with FirstTransaction as
(select TransactionID,date,CustomerID,Amount,
row_number() over(partition by CustomerID order by date) [DR]
from Enterprise
)

select * from FirstTransaction
where DR=1

--9) Last Transaction of every Customer.
with LastTransaction as
(select TransactionID,date,CustomerID,Amount,
row_number() over(partition by CustomerID order by date desc) [DR]
from Enterprise
)

select * from LastTransaction
where DR=1

--10) Rank Customers by Total Spending
select CustomerID,
round(SUM(Amount),2) [Spending Amount],
dense_RANK() over(order by SUM(Amount) desc) [Customer Rank]
from Enterprise
group by CustomerID
order by [Customer Rank]