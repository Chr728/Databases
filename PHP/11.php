<?php
function autoloaderPhp($class){
    require("./" . $class . ".php");
  }
  spl_autoload_register("autoloaderPhp");
  DAOConstants::$pdo = new PDO("mysql:host=" . DAOConstants::host
    . "; port=3306; dbname=" . DAOConstants::dbname,
  DAOConstants::user, DAOConstants::password);
  DAOConstants::$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 

  
  ConstantValue::createHeader("Question 11");
  echo '<div class="main-center">';
  echo '<ul>';

  
  function CallQuery(){
    try{
     
      $sql = 'select 
        companyName as "Company Name",
        (select facility.address from facility join headOffice on facility.facility_ID = headOffice.facility_ID 
        where headOffice.company_ID = pharmaCompanyOuter.company_ID) as "Head Office Address",
        (select concat(firstName, " ", lastName) from employee join
        headOffice on headOffice.CEO_SSN = employee.SSN where headOffice.position = (select position_ID from jobPosition where jobTitle="CEO") and (endDate is null or endDate > current_date())
        and headOffice.company_ID = pharmaCompanyOuter.company_ID) as "CEO Name",
        (select count(SSN) from employee where employee.company_ID = pharmaCompanyOuter.company_ID) as "Number of employees",
        (select count(researchCenter.facility_ID) from researchCenter join facility on researchCenter.facility_ID = facility.facility_ID where facility.company_ID = pharmaCompanyOuter.company_ID)
        as "Number of Research Centers",
        (select count(SSN) from employee where employee.position = (select position_ID from jobPosition where jobTitle="Researcher") 
        and employee.company_ID = pharmaCompanyOuter.company_ID) as "Number of Researchers",
        (select count(manufacturing.facility_ID) from manufacturing join facility on manufacturing.facility_ID = facility.facility_ID where facility.company_ID = pharmaCompanyOuter.company_ID) 
        as "Number of manufacturing facilities",
        (select sum(maxProdCapacity) from manufacturing join facility on manufacturing.facility_ID = facility.facility_ID where facility.company_ID = pharmaCompanyOuter.company_ID)
        as " Total Max Production Capacity",
        (select count(warehouse.facility_ID) from warehouse join facility on warehouse.facility_ID = facility.facility_ID where facility.company_ID = pharmaCompanyOuter.company_ID)
        as "Number of warehouses facilities",
        (select sum(maxStoringCapacity) from warehouse join facility on warehouse.facility_ID = facility.facility_ID where facility.company_ID = pharmaCompanyOuter.company_ID)
        as " Total Maximum Storing Capacity"
        from pharmaCompany as pharmaCompanyOuter group by pharmaCompanyOuter.company_ID';
  
      foreach (DAOConstants::$pdo->query($sql) as $row) {
        $headOfficeLocation = $row[1];
        $ceoName= $row[2];
        $warehouseCapacity = $row[9];
        if (empty($headOfficeLocation) === true)
          $headOfficeLocation = "No Head Office location has been inserted";
        if (empty($ceoName) === true)
          $ceoName = "No CEO has been appointed to this company yet";
        if(empty($warehouseCapacity) === true)
          $warehouseCapacity = "0";
        echo '<li><p> Company Name: ' . $row[0] .' <br> Head Office Location: '. $headOfficeLocation .' <br> CEO\'s Name: '. $ceoName .' <br> Total Number Of Employees: '. $row[3].' <br> Number of Research Facilities: '. $row[4].' <br> Total Number of Researchers: '. $row[5].' <br> Number of Manufacturing Facilities: '. $row[6].' <br> Number of Production Capacity: '. $row[7].' <br> Number of Warehouses: '. $row[8].' <br> Number of capacities for the Warehouses: '. $warehouseCapacity . '</p></li>' ;  
      }
      echo "</ul>";
    
    } catch(PDOException $e){
        echo "</ul>";
        echo $e->getMessage();
        echo ConstantValue::footer;
        exit;
    }
  }



  CallQuery();
  echo ConstantValue::footer;
?>