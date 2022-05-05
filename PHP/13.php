<?php
function autoloaderPhp($class){
    require("./" . $class . ".php");
  }
  spl_autoload_register("autoloaderPhp");
  DAOConstants::$pdo = new PDO("mysql:host=" . DAOConstants::host
    . "; port=3306; dbname=" . DAOConstants::dbname,
  DAOConstants::user, DAOConstants::password);
  DAOConstants::$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 

  
  ConstantValue::createHeader("Question 13");
  echo '<div class="main-center">';
  echo '<ul>';


  function CallQuery(){
    try{

      $sql = "select pharmaCompany.companyName as \"Pharma Company\", facility.address AS \"H.O. Address\",facility.province AS \"H.O. Province\",facility.postalCode AS \"H.O. Postal Code\", facility.city AS \"H.O. City\", facility.country AS \"H.O. Country\" 
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
      GROUP BY pharmaCompany.companyName 
      ORDER BY contract.contract_ID) AND facility.facilityType = \"Head Office\" 
      GROUP BY pharmaCompany.companyName";
      
      foreach (DAOConstants::$pdo->query($sql) as $row) {
          echo '<li><p> Pharma company : ' .$row[0].' <br> H.O Address: '. $row[1].' <br> H.O Province: '. $row[2].' <br> H.O Postal Code: '. $row[3].' <br> H.O city: '. $row[4].' <br> H.O country: '. $row[5].'</p></li>' ;  
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