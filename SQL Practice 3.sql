/* Exercise 1. From dbo.DimProduct, dbo.DimPromotion, dbo.FactInternetSales,  
Write a query display ProductKey, EnglishProductName which has Discount Pct >= 20% */

-- Your code here  

SELECT Sales.ProductKey, 
EnglishProductName
FROM dbo.FactInternetSales as Sales 
LEFT JOIN dbo.DimProduct as DP 
ON Sales.ProductKey = DP.ProductKey
LEFT JOIN dbo.DimPromotion as DPromo 
ON Sales.PromotionKey = DPromo.PromotionKey
WHERE DiscountPct >= 0.2

/* Exercise 2. From dbo.DimProduct and DimProductSubcategory, DimProductCategrory 
Write a query displaying the Product key, EnglishProductName, EnglishProductSubCategoryName , 
EnglishProductCategroyName columns of product which has EnglishProductCategoryName is 'Clothing' */

-- Your code here  

 
select ProductKey, 
EnglishProductName, 
EnglishProductSubcategoryName, 
EnglishProductCategoryName 
from dbo.DimProduct as Product
left join dbo.DimProductSubcategory as SubCat 
on SubCat.ProductSubcategoryKey = Product.ProductSubcategoryKey
left join dbo.DimProductCategory as Cat 
on Cat.ProductCategoryKey = SubCat.ProductCategoryKey
where EnglishProductCategoryName = 'Clothing'


/* Exercise 3. From FactInternetSales, DimProduct  
Display ProductKey, EnglishProductName, ListPrice of products which never have been sold  */

-- Your code here  

-- WAY 1 
select ProductKey, 
EnglishProductName, 
ListPrice
from dbo.DimProduct 
where ProductKey not in (select distinct ProductKey from FactInternetSales)


-- WAY 2
select Product.ProductKey, EnglishProductName
from dbo.DimProduct as Product
left join dbo.FactInternetSales as Sales
on Sales.ProductKey = Product.ProductKey
where Sales.SalesOrderNumber is null  


/* Exercise 4. From DimDepartmentGroup, Write a query display DepartmentGroupName and
their parent DepartmentGroupName */ 

-- Your code here  

select Dchild.DepartmentGroupKey,
		Dchild.DepartmentGroupName,
		Dparent.DepartmentGroupKey as ParentDepartGroupKey,
		Dparent.DepartmentGroupName as ParentDepartGroupName
		from dbo.DimDepartmentGroup as Dchild
left join dbo.DimDepartmentGroup as Dparent 
on Dchild.ParentDepartmentGroupKey = Dparent.DepartmentGroupKey; 

/* Exercise 5. (hard) From FactFinance, DimOrganization, DimScenario 
Write a query display OrganizationKey, OrganizationName, Parent OrganizationKey, Parent OrganizationName, Amount 
where ScenarioName is 'Actual'  */ 

-- Your code here  

select
		child_Org.OrganizationKey,
		child_Org.OrganizationName,
		parent_Org.OrganizationKey as 'Parent OrganizationKey',
		parent_Org.OrganizationName as 'Parent OrganizationName',
		Amount
from dbo.FactFinance as Fin
left join dbo.DimScenario as Scen 
on Scen.ScenarioKey = Fin.ScenarioKey
left join dbo.DimOrganization as child_Org 
on child_Org.OrganizationKey = Fin.OrganizationKey
left join dbo.DimOrganization parent_Org
on parent_Org.OrganizationKey = child_Org.ParentOrganizationKey
where ScenarioName = 'Actual'
  

 

 

 

 