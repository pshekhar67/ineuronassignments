
----ASSIGNMENT

Use database Demo_Database;

Create or Replace Table SP_Sales_Data_Final
(
    Order_Id Varchar (20),
    Order_Date Date Primary Key, -- In below one 
    Ship_Date Date,
    Ship_Mode Varchar (20),
    Customer_Name Varchar (30),
    Segment Varchar (20),
    State Varchar (75),
    Country Varchar (50),
    Market Varchar (20),
    Region Varchar (20),
    Product_Id Varchar (30),
    Catrgory Varchar (20),
    Sub_Category Varchar (20),
    Product_Name Varchar (200),
    Sales Number (10,0),
    Quantity Number (5,0),
    Discount Number (5,1),
    Profit Float,
    Shipping_Cost Number (5,2),
    Order_Prority Varchar (20),
    Year Number (4,0)
    
);


select * from SP_Sales_Data_Final;

create or replace file format my_csv_format
  type = csv
  record_delimiter = '\n'
  field_delimiter = ','
  skip_header = 1
  null_if = ('NULL', 'null')
  empty_field_as_null = false
  FIELD_OPTIONALLY_ENCLOSED_BY = '0x22';


select * from SP_Sales_Data_Final;

--ASSIGNMENT --Anser to question 2 to change Primary Key from Column Order_Date to Order_Id;

Alter Table SP_Sales_Data_Final drop Primary Key;
Alter Table SP_Sales_Data_Final add primary key (Order_Id);
Describe table SP_Sales_Data_Final; -- to check whether primary key is changed from Order_Date to Order Id;


--ASSIGNMENT --Answer for Question 3 is the Data Type for Order_Date & Ship_Date should be "DATE" in fomart - (YYYY-MM-DD).


Alter table SP_Sales_Data_Final Add Column Order_Extract Number (10,0);

--Assignment --4. Create a new column called order_extract and extract the number after the last

Select Order_Id, substring (Order_Id, 9,9) as Order_Extract
from SP_Sales_Data_Final;

--ASSIGNMENT -- Answer for Question 5 Create column for DIscount Flag

select discount,
    case 
        when Discount = '0' then 'No'
        else 'Yes'
    end as Discount_Flag
From SP_Sales_Data_Final;

--ASSIGNMENT --Answer for 6th Question as below.

select Order_Date, Ship_Date, datediff (Day, Order_Date,Ship_Date) as Days_Required_to_Ship

From SP_Sales_Data_Final;


--ASSIGNMENT -- Answer for Question 7 Creating a new column called rating.

Select Order_Date, Ship_Date,datediff (Day, Order_Date,Ship_Date) as Days_Required_to_Ship,
    Case 
        when Datediff (Day, Order_Date,Ship_Date) <= '3' then '5'
        When Datediff (Day, Order_Date,Ship_Date) > '3' AND Datediff (Day, Order_Date,Ship_Date) <= '6' then '4'
        When Datediff (Day, Order_Date,Ship_Date) > '6' AND Datediff (Day, Order_Date,Ship_Date) <= '10' then '3'
        When Datediff (Day, Order_Date,Ship_Date) > '10' then '2'
    End as Delivery_Rating
From SP_Sales_Data_Final;

