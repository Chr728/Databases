USE coc353_4;
SET SQL_SAFE_UPDATES = 0;

-- questions 11
select 
companyName as "Company Name",
	(select facility.address from facility join headOffice on facility.facility_ID = headOffice.facility_ID 
     where headOffice.company_ID = pharmaCompanyOuter.company_ID) as "Head Office Address",
	(select concat(firstName, " ", lastName) from employee join
	headOffice on headOffice.CEO_SSN = employee.SSN where headOffice.position = (select position_ID from jobPosition where jobTitle="CEO") and (endDate is null or endDate > current_date())
	and headOffice.company_ID = pharmaCompanyOuter.company_ID) as "CEO Name",
	(select count(ssn) from employee where employee.company_ID = pharmaCompanyOuter.company_ID) as "Number of employees",
	(select count(researchCenter.facility_id) from researchCenter join facility on researchCenter.facility_id = facility.facility_id where facility.company_ID = pharmaCompanyOuter.company_ID)
    as "Number of Research Centers",
	(select count(ssn) from employee where employee.position = (select position_id from jobPosition where jobTitle="Researcher") 
    and employee.company_ID = pharmaCompanyOuter.company_ID) as "Number of Researchers",
	(select count(manufacturing.facility_id) from manufacturing join facility on manufacturing.facility_id = facility.facility_id where facility.company_ID = pharmaCompanyOuter.company_ID) 
    as "Number of manufacturing facilities",
    (select sum(maxProdCapacity) from manufacturing join facility on manufacturing.facility_id = facility.facility_id where facility.company_ID = pharmaCompanyOuter.company_ID)
    as " Total Max Production Capacity",
    (select count(warehouse.facility_id) from warehouse join facility on warehouse.facility_id = facility.facility_id where facility.company_ID = pharmaCompanyOuter.company_ID)
    as "Number of warehouses facilities",
    (select sum(maxStoringCapacity) from warehouse join facility on warehouse.facility_id = facility.facility_id where facility.company_ID = pharmaCompanyOuter.company_ID)
    as " Total Maximum Storing Capacity"
from pharmaCompany as pharmaCompanyOuter group by pharmaCompanyOuter.company_ID;

-- questions 12
select pharmaCompany.companyname AS 'Pharma. Company', facilityOuter.country AS 'Company Country', sum(maxstoringcapacity) as "Total Storing Capacity" from pharmaCompany join 
facility as facilityOuter on pharmaCompany.company_ID = facilityOuter.company_ID join warehouse on facilityOuter.facility_id = warehouse.facility_id where
facilityOuter.country in (select country from client join contract on client.client_id = contract.client_id where facilityOuter.country = client.country)
group by pharmaCompany.company_ID, facilityOuter.country;

-- questions 13
SELECT pharmaCompany.companyName AS 'Pharma Company', facility.address AS 'H.O. Address',facility.province AS 'H.O. Province',facility.postalCode AS 'H.O. Postal Code', facility.city AS 'H.O. City', facility.country AS 'H.O. Country'
FROM pharmaCompany
JOIN facility ON pharmaCompany.company_ID = facility.company_ID
WHERE pharmaCompany.companyName NOT IN (
SELECT pharmaCompany.companyName
FROM contract
JOIN headOffice ON contract.employee_SSN = headOffice.CEO_SSN
JOIN client ON contract.client_ID = client.client_ID
JOIN facility ON headOffice.facility_ID = facility.facility_ID
JOIN pharmaCompany ON facility.company_ID = pharmaCompany.company_ID
WHERE facility.country = client.country
GROUP BY pharmaCompany.companyname
ORDER BY contract.contract_ID) AND facility.facilitytype = 'Head Office'
GROUP BY pharmaCompany.companyname;

/*Updated from contract.contactName to contract.clientName, for first column */
select contract.clientname AS 'Client',  contractDate AS 'Contract Date', product.name AS 'Product', purchase.quantity AS 'Quantity', concat(round(quantity*unitPrice,2), " $") as "Contract Total Value" from contract join purchase
on contract.contract_id = purchase.contract_id join product on purchase.product_id = product.upc join pharmaCompany on 
contract.company_ID = pharmaCompany.company_ID join client on contract.client_id = client.client_id where pharmaCompany.companyName = "Pfizer";


/* group by pharmaCompany.company_ID */

-- questions 15
SELECT  contract.clientName AS 'Client', pharmaCompany.companyName AS 'Pharmaceutical Company', contract.contractDate AS 'Contract Date', product.name AS 'Product',
SUM(purchase.quantity) AS 'Quantity', CONCAT(ROUND(SUM(purchase.quantity*purchase.unitPrice), 2), '$') AS 'Contract Value'
FROM contract
JOIN client ON contract.client_ID = client.client_ID
JOIN pharmaCompany ON contract.company_ID = pharmaCompany.company_ID
JOIN purchase ON contract.contract_ID = purchase.contract_ID
JOIN product ON purchase.product_ID = product.UPC
GROUP BY contract.contract_ID
ORDER BY ROUND(SUM(purchase.quantity*purchase.unitPrice), 2) DESC;

-- questions 16
select ssn AS 'SSN', firstname AS 'First Name', lastname AS 'Last Name', citizenship AS 'Citizenship', GROUP_CONCAT(companyName SEPARATOR ' + ') as "Companies worked/working for" from employee 
join pharmaCompany on employee.company_ID = pharmaCompany.company_ID 
where employee.position = (select position_id from jobPosition where jobTitle="Researcher") group by ssn having count(employee.company_ID) >=3 
order by ssn desc;

-- questions 17
select firstname AS 'First Name', lastname AS 'Last Name', email , sum(totalhours) as "Hours worked" from employee join pharmaCompany on employee.company_ID = pharmaCompany.company_ID join
researchAssignment on researchAssignment.researcher_SSN = employee.ssn where pharmaCompany.companyname = "pfizer" group by ssn;

-- questions 18
select distinct firstname AS 'First Name', lastname AS 'Last Name', email, sum(totalhours) as "Hours worked" from employee join pharmaCompany on employee.company_ID = pharmaCompany.company_ID join
researchAssignment on researchAssignment.researcher_SSN = employee.ssn group by ssn, pharmaCompany.company_ID order by sum(totalhours) desc;

-- questions 19
SELECT facility.facilityName AS 'R.C. Facility Name', facility.address AS 'Facility Address', facility.city AS 'Facility City', 
facility.Country AS 'Facility Country', team.teamName AS 'Team', project.projectName AS 'Project', 
project.startDate AS 'Start Date', project.endDate AS 'End Date', COUNT(researchAssignment.researcher_SSN) AS 'Number of Researchers', SUM(researchAssignment.totalHours) AS 'Total Hours'
FROM facility 
JOIN team ON facility.company_ID = team.company_ID
JOIN project ON team.team_ID = project.team_ID
JOIN researchAssignment ON project.project_ID = researchAssignment.project_ID
WHERE facility.country = 'USA' 
GROUP BY project.project_ID; 

-- questions 20
select companyname AS 'Pharma. Company', year(contractDate) AS 'Year', concat(round(sum(quantity*unitPrice),2), " $") as "Total Sales" from pharmacompany join contract on pharmacompany.company_id = contract.company_id
join purchase on purchase.contract_id = contract.contract_id where year(contractdate) >= 2019 and year(contractdate) <= 2022 
group by pharmacompany.company_id, year(contractdate) order by year(contractdate) desc, round(sum(quantity*unitPrice),2) desc;
