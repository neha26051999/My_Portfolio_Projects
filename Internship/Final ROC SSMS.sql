SELECT * FROM ROC

--- Checking For Duplicates ---

SELECT CIN, CompanyName, CompanyROCcode, CompanyCategory, CompanySubCategory, CompanyClass, AuthorizedCapital, PaidupCapital, CompanyRegistration_date,
Registered_Office_Address, Listingstatus, CompanyStatus, CompanyStateCode, CompanyIndian_Foreign_Company, nic_code, CompanyIndustrialClassification, count(*) as duplicates
FROM ROC
GROUP BY CIN, CompanyName, CompanyROCcode, CompanyCategory, CompanySubCategory, CompanyClass, AuthorizedCapital, PaidupCapital, CompanyRegistration_date,
Registered_Office_Address, Listingstatus, CompanyStatus, CompanyStateCode, CompanyIndian_Foreign_Company, nic_code, CompanyIndustrialClassification
having count(*) > 1

--- Removing Duplicates ---

WITH DuplicatesCTE AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY 
                CIN, CompanyName, CompanyROCcode, CompanyCategory, CompanySubCategory, CompanyClass, AuthorizedCapital,
                PaidupCapital, CompanyRegistrationdate_date, Registered_Office_Address, CompanyStateCode, CompanyIndian_Foreign_Company,
                nic_code, CompanyIndustrialClassification
            ORDER BY (SELECT NULL)  
        ) AS rn
    FROM ROC
)
DELETE FROM DuplicatesCTE
WHERE rn > 1;
 
select* from ROC

---Checking if each coloumn data formatted properly---
select * from ROC

select distinct (CIN) FROM ROC

select distinct (Company_Name) from ROC

select distinct(Company_ROC_code) from ROC

select distinct (Company_Category) from ROC;

select distinct (Company_Sub_Category) from ROC;

select distinct (Company_Class) from ROC;

select distinct (Authorized_Capital) from ROC

select distinct (Paidup_Capital) from ROC

select distinct (Company_Registration_date) from roc

select distinct (Registered_Office_Address) from roc

select distinct (Listingstatus) from ROC

select distinct (Company_Status) from ROC

select distinct (Company_State_Code) from ROC

select distinct (CompanyIndian_Foreign_Company) from ROC

select distinct (nic_code) from ROC

select distinct (Company_Industrial_Classification) from ROC

-------Checking NULLS-----------

select * from ROC

SELECT * 
FROM ROC
where CIN IS NULL
 
SELECT * 
FROM ROC
where Company_Name IS NULL 

SELECT * 
FROM ROC
where Company_ROC_Code IS NULL 

SELECT * 
FROM ROC
where Company_Category IS NULL 

SELECT * 
FROM ROC
where Company_Sub_Category IS NULL 

SELECT * 
FROM ROC
where Company_Class IS NULL 

select * from ROC
where Authorized_Capital is NULL

SELECT * 
FROM ROC
where Paidup_Capital IS NULL



SELECT 
    Company_Class,
    AVG(Paidup_Capital) AS MeanPaidupCapital
FROM ROC
   
WHERE 
    Paidup_Capital IS NOT NULL
GROUP BY 
    Company_Class;


SELECT * 
FROM ROC
where Company_Registration_Date IS NULL

SELECT * 
FROM ROC
where Registered_office_Address  IS NULL 

SELECT * 
FROM ROC
where Listingstatus is NULL 

SELECT * 
FROM ROC
where Company_Status IS NULL 
 
SELECT * 
FROM ROC
where Company_State_Code IS NULL 

SELECT * 
FROM ROC
where CompanyIndian_Foreign_Company IS NULL 

SELECT * FROM ROC
WHERE nic_code is NULL

SELECT * FROM ROC
WHERE Company_Industrial_Classification is NULL

------- Changing the date type in date to varchar CompanyRegistrationdate_date -------
ALTER TABLE ROC
ALTER COLUMN CompanyRegistration_Date VARCHAR(50);

-----List of companies who have registered outside Karnataka but have roc state code as Karnataka----
 select Company_ROC_Code, Company_State_Code from roc
WHERE Company_ROC_Code <> 'ROC Bangalore' 

select * from ROC

---Calculate the mean paid up capital in the company class---
SELECT 
    Company_Class,
    AVG(Paidup_Capital) AS MeanPaidupCapital
FROM ROC
   
WHERE 
    Paidup_Capital IS NOT NULL
GROUP BY 
    Company_Class;

--- Paid up capital mean---
WITH ClassMean AS (
    SELECT 
        Company_Class,
        AVG(Paidup_Capital) AS MeanPaidupCapital
    FROM ROC
    WHERE Paidup_Capital IS NOT NULL
    GROUP BY Company_Class
)

UPDATE r
SET r.Paidup_Capital = cm.MeanPaidupCapital
FROM ROC r
JOIN ClassMean cm 
    ON r.Company_Class = cm.Company_Class
WHERE r.Paidup_Capital IS NULL;

SELECT 
    Company_Class,
    AVG(Paidup_Capital) AS MeanPaidupCapital
FROM ROC
   
WHERE 
    Paidup_Capital IS NOT NULL
GROUP BY 
    Company_Class;

---Calculate the mean Authorized capital in the company class---
SELECT 
    Company_Class,
    AVG(Authorized_Capital) AS MeanAuthorizedCapital
FROM ROC
   
WHERE 
  Authorized_Capital IS NOT NULL
GROUP BY 
    Company_Class;

------------Authorized capital mean-----------        
WITH ClassMean AS (
SELECT 
 Company_Class,
AVG(Authorized_Capital) AS MeanAuthorizedCapital
FROM ROC
WHERE Authorized_Capital IS NOT NULL
GROUP BY Company_Class
)

UPDATE r
SET r.Authorized_Capital = cm.MeanAuthorizedCapital
FROM ROC r
JOIN ClassMean cm 
    ON r.Company_Class = cm.Company_Class
WHERE r.Authorized_Capital is  NULL;

SELECT * FROM ROC WHERE Paidup_Capital IS NULL;
SELECT * FROM ROC WHERE Authorized_Capital is null;

select * from ROC

-----------Renaming the columns -----------
EXEC sp_rename 'ROC.CompanyName', 'Company_Name', 'COLUMN';
EXEC sp_rename 'ROC.CompanyROCcode', 'Company_ROC_Code', 'COLUMN';
EXEC sp_rename 'ROC.CompanyCategory', 'Company_Category', 'COLUMN';
EXEC sp_rename 'ROC.CompanySubCategory', 'Company_Sub_Category', 'COLUMN';
EXEC sp_rename 'ROC.CompanyClass', 'Company_Class', 'COLUMN';
EXEC sp_rename 'ROC.AuthorizedCapital', 'Authorized_Capital', 'COLUMN';
EXEC sp_rename 'ROC.PaidupCapital', 'Paidup_Capital', 'COLUMN';
EXEC sp_rename 'ROC.CompanyRegistration_Date', 'Company_Registration_Date', 'COLUMN';
EXEC sp_rename 'ROC.CompanyStatus', 'Company_Status', 'COLUMN';
EXEC sp_rename 'ROC.CompanyStateCode', 'Company_State_Code', 'COLUMN';
EXEC sp_rename 'ROC.CompanyIndian_Foregin_Company', 'Company_Indian_Foregin_Company', 'COLUMN';
EXEC sp_rename 'ROC.CompanyIndustrialClassification', 'Company_Industrial_Classification', 'COLUMN';

SELECT * FROM ROC

-------remove the ROC bangalore  ----------
SELECT 
    Company_ROC_Code, 
    Company_State_Code
FROM  ROC
WHERE  Company_ROC_Code <> 'ROC Bangalore';

 SELECT* FROM ROC

---Filled NULLS in Company_Registration_Date column----------
  WITH filled AS (
    SELECT 
        Company_Registration_Date,
        LEAD(Company_Registration_Date) OVER (ORDER BY Company_Registration_Date) AS next_date
    FROM ROC
)
UPDATE ROC
SET Company_Registration_Date = filled.next_date
FROM filled
WHERE ROC.Company_Registration_Date IS NULL AND filled.Company_Registration_Date IS NULL;

-------CREATED NEW TABLE FOR COMPANIES FROM OTHER STATE WHO GOT REGIESTERED IN 
-------IN THEIR STATE AND STARTED THEIE BUSINESS IN KARNATAKA......

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE CODE(
	[CIN] [nvarchar](50) NOT NULL,
	[Company_Name] [nvarchar](100) NOT NULL,
	[Company_ROC_Code] [nvarchar](50) NOT NULL,
	[Company_Category] [nvarchar](50) NOT NULL,
	[Company_Sub_Category] [nvarchar](50) NOT NULL,
	[Company_Class] [nvarchar](50) NOT NULL,
	[Authorized_Capital] [bigint] NULL,
	[Paidup_Capital] [bigint] NULL,
	[Company_Registration_Date] [varchar](50) NULL,
	[Registered_Office_Address] [varchar](max) NULL,
	[Listingstatus] [nvarchar](50) NOT NULL,
	[Company_Status] [nvarchar](50) NOT NULL,
	[Company_State_Code] [nvarchar](50) NOT NULL,
	[CompanyIndian_Foreign_Company] [nvarchar](50) NOT NULL,
	[nic_code] [int] NULL,
	[Company_Industrial_Classification] [varchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


INSERT INTO CODE
(
    [CIN], 
    [Company_Name], 
    [Company_ROC_Code], 
    [Company_Category], 
    [Company_Sub_Category], 
    [Company_Class], 
    [Authorized_Capital], 
    [Paidup_Capital], 
    [Company_Registration_Date], 
    [Registered_Office_Address], 
    [Listingstatus], 
    [Company_Status], 
    [Company_State_Code], 
    [CompanyIndian_Foreign_Company], 
    [nic_code], 
    [Company_Industrial_Classification]
)
SELECT 
    [CIN], 
    [Company_Name], 
    [Company_ROC_Code], 
    [Company_Category], 
    [Company_Sub_Category], 
    [Company_Class], 
    [Authorized_Capital], 
    [Paidup_Capital], 
    [Company_Registration_Date], 
    [Registered_Office_Address], 
    [Listingstatus], 
    [Company_Status], 
    [Company_State_Code], 
    [CompanyIndian_Foreign_Company], 
    [nic_code], 
    [Company_Industrial_Classification]
FROM [dbo].[ROC] 
WHERE 
    [Company_ROC_Code] NOT LIKE '%Bangalore%'  -- Exclude Bangalore from ROC Code
    AND [Company_State_Code] <> 'KA';         -- Exclude Karnataka (KA) from State Code

---Renaming industrial classfication column's data --- 
SELECT DISTINCT(Company_Industrial_Classification)
FROM CODE
WHERE Company_Industrial_Classification LIKE '%Manufacturing%'

UPDATE CODE
SET Company_Industrial_Classification = 'Manufacturing'
WHERE Company_Industrial_Classification = 'Manufacturing (Food stuffs)';

UPDATE CODE
SET Company_Industrial_Classification = 'Manufacturing'
WHERE Company_Industrial_Classification = 'Manufacturing (Metals and Chemicals, and products thereof)';

SELECT DISTINCT(Company_Industrial_Classification)
FROM ROC
WHERE Company_Industrial_Classification LIKE '%Manufacturing%'

UPDATE ROC
SET Company_Industrial_Classification = 'Manufacturing'
WHERE Company_Industrial_Classification = 'Manufacturing (Food stuffs)';

UPDATE ROC
SET Company_Industrial_Classification = 'Manufacturing'
WHERE Company_Industrial_Classification = 'Manufacturing (Leather and products thereof)';

UPDATE ROC
SET Company_Industrial_Classification = 'Manufacturing'
WHERE Company_Industrial_Classification = 'Manufacturing (Metals and Chemicals, and products thereof)';

UPDATE ROC
SET Company_Industrial_Classification = 'Manufacturing'
WHERE Company_Industrial_Classification = 'Manufacturing (Machinery and Equipments)';

UPDATE ROC
SET Company_Industrial_Classification = 'Manufacturing'
WHERE Company_Industrial_Classification = 'Manufacturing (Paper and Paper products, Publishing, printingand reproduction of recorded media)';

UPDATE ROC
SET Company_Industrial_Classification = 'Manufacturing'
WHERE Company_Industrial_Classification = 'Manufacturing (Others)';

UPDATE ROC
SET Company_Industrial_Classification = 'Manufacturing'
WHERE Company_Industrial_Classification = 'Manufacturing (Textiles)';

UPDATE ROC
SET Company_Industrial_Classification = 'Manufacturing'
WHERE Company_Industrial_Classification = 'Manufacturing (Wood Products)';


------Analysing the data -------- 

-----1.What is the total number of companies recorded in the dataset?----
SELECT COUNT(DISTINCT company_name) AS TotalCompanies
FROM ROC;
	
---2.How are the companies distributed across different categories?
SELECT Company_Category, COUNT(*) as Num_of_companies
FROM ROC 
GROUP BY Company_Category

---3.How are the companies distributed across different sub categories?
SELECT Company_Sub_Category, COUNT(*) as Num_of_Companies
FROM ROC 
GROUP BY Company_Sub_Category
ORDER BY Num_of_Companies DESC 

---4.What is the total number of companies in each class?
SELECT Company_Class, COUNT(*) as Num_of_Companies
FROM ROC 
GROUP BY Company_Class
ORDER BY Num_of_Companies DESC

---5.In which year was the highest number of companies registered?---
SELECT TOP 1
    YEAR(Company_Registration_Date) AS Registration_Year,
    COUNT(*) AS Company_Count
FROM ROC
GROUP BY YEAR(Company_Registration_Date)
ORDER BY Company_Count DESC

---6.Which are the top 5 companies with the highest authorised capital and the bottom 5 with the lowest?---
SELECT TOP 5 
    Company_Name, 
    Authorized_Capital
FROM ROC
ORDER BY  Authorized_Capital DESC ---top 5---

SELECT TOP 5 
    Company_Name, 
    Authorized_Capital
FROM ROC
ORDER BY Authorized_Capital ASC---Bottom 5---

---7.What is the number of listed and unlisted companies?---
SELECT 
   Listingstatus,
    COUNT(*) AS CompanyCount
FROM ROC
GROUP BY Listingstatus;

---8.Present the count of companies based on their respective statuses?---
SELECT 
    Company_Status AS Status,
    COUNT(*) AS CompanyCount
FROM ROC
GROUP BY Company_Status
ORDER BY CompanyCount DESC;

---9.What is the number of companies categorized by industrial classification?---
SELECT top 5
  Company_Industrial_Classification,
    COUNT(*) AS CompanyCount
FROM ROC
GROUP BY Company_Industrial_Classification
ORDER BY CompanyCount DESC;

---10. Which company category has the highest Authorized Capital? 
---Also, display the corresponding paid-up capital for each---

SELECT TOP 1 Company_Name, Authorized_Capital, Paidup_Capital
FROM ROC
ORDER BY Authorized_Capital DESC --highest--
 
---11.Categorize average authorised capital and average  paid-up capital based on company class?---

SELECT 
   Company_Class,
    AVG(Authorized_Capital ) AS AvgAuthorized_Capital,
    AVG(PaidUp_Capital)AS AvgPaidUp_Capital
FROM ROC
GROUP BY Company_Class
ORDER BY AvgAuthorized_Capital DESC;

---12.Categorise average authorised capital and average paid-up capital based on company sub category?---
SELECT 
    Company_Sub_Category,
    AVG(Authorized_Capital) AS AvgAuthorized_Capital,
    AVG(PaidUp_Capital) AS AvgPaidUpCapital
FROM ROC
GROUP BY Company_Sub_Category
ORDER BY AvgAuthorized_Capital DESC;

---13.Which industry has highest average authorised capital and which has lowest authorised capital?
SELECT TOP 1
    Company_Industrial_Classification,
    AVG(Authorized_Capital) AS AvgAuthorizedCapital
FROM ROC
GROUP BY Company_Industrial_Classification
ORDER BY AvgAuthorizedCapital DESC;

SELECT TOP 1
   Company_Industrial_Classification,
    AVG(Authorized_Capital)AS AvgAuthorized_Capital
FROM ROC
GROUP BY (Company_Industrial_Classification)
ORDER BY AvgAuthorized_Capital;

---14.Which year saw the most company strike-offs?---
SELECT TOP 1
    YEAR(Company_Registration_Date) AS StrikeOffYear,
    COUNT(*) AS StrikeOffCount
FROM ROC
GROUP BY YEAR(Company_Registration_Date)
ORDER BY StrikeOffCount DESC;

--15.Are there any companies with authorised capital but zero paid-up capital?---
SELECT COUNT(*) AS ZeroPaidUpCapitalCompanies
FROM ROC
WHERE 
   Authorized_Capital > 0 AND 
   Paidup_Capital = 0;

--16.Are there companies where paid-up capital exceeds authorized capital?
SELECT COUNT(*) AS OverPaidCapitalCompanies
FROM ROC
WHERE 
    Authorized_Capital >= 0 AND 
   Paidup_Capital > Authorized_Capital;

--17.What percentage of companies fall into the top 5 most common company categories?---
WITH TotalCompanies AS (
    SELECT COUNT(*) AS TotalCount
    FROM ROC
),

Top5Categories AS (
    SELECT TOP 5 
        Company_Category,
        COUNT(*) AS CategoryCount
    FROM ROC
    GROUP BY Company_Category
    ORDER BY CategoryCount DESC
)

SELECT 
    T5.Company_Category,
    T5.CategoryCount,
    CAST(T5.CategoryCount AS FLOAT) / T.TotalCount * 100 AS PercentageOfTotal
FROM Top5Categories T5
CROSS JOIN TotalCompanies T
ORDER BY T5.CategoryCount DESC;
SELECT *
FROM ROC
WHERE 
    TRY_CAST([Company_Registration_Date] AS DATE) >= DATEADD(YEAR, -1, GETDATE()) 
    AND Company_Status = 'Strike Off';

---18.List of companies who have registered outside Karnataka but have roc state code as Karnataka---
SELECT Company_Name, Company_ROC_Code, Company_State_Code
FROM CODE






