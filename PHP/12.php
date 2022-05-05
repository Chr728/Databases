<?php
function autoloaderPhp($class){
    require("./" . $class . ".php");
  }
  spl_autoload_register("autoloaderPhp");
  DAOConstants::$pdo = new PDO("mysql:host=" . DAOConstants::host
    . "; port=3306; dbname=" . DAOConstants::dbname,
  DAOConstants::user, DAOConstants::password);
  DAOConstants::$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 

  
  ConstantValue::createHeader("Question 12");
  echo '<div class="main-center">';
  echo '<ul>';

  
  function CallQuery(){
    try{
     
      $sql = "select pharmaCompany.companyName, facilityOuter.country, sum(maxStoringCapacity) as \"Total Storing Capacity\" from pharmaCompany join 
      facility as facilityOuter on pharmaCompany.company_ID = facilityOuter.company_ID join warehouse on facilityOuter.facility_ID = warehouse.facility_ID where 
      facilityOuter.country in (select country from client join contract on client.client_ID = contract.client_ID where facilityOuter.country = client.country) 
      group by pharmaCompany.company_ID, facilityOuter.country";
  
      foreach (DAOConstants::$pdo->query($sql) as $row) {
          echo '<li><p> Company Name: ' .$row[0].' <br> Country Name: '. $row[1].' <br> Number of capacities for Warehouses in that country: '. $row[2]. '</p></li>' ;  
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