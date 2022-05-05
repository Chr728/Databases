<?php
function autoloaderPhp($class){
    require("./" . $class . ".php");
  }
  spl_autoload_register("autoloaderPhp");
  DAOConstants::$pdo = new PDO("mysql:host=" . DAOConstants::host
    . "; port=3306; dbname=" . DAOConstants::dbname,
  DAOConstants::user, DAOConstants::password);
  DAOConstants::$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 

  
  ConstantValue::createHeader("Question 16");
  echo '<div class="main-center">';
  echo '<ul>';
  
  function CallQuery(){
    try{
     
      $sql = "select SSN, firstName, lastName, citizenship, GROUP_CONCAT(companyName SEPARATOR ' + ') as \"Companies worked/working for\" from employee 
      join pharmaCompany on employee.company_ID = pharmaCompany.company_ID
      where employee.position = (select position_ID from jobPosition where jobTitle= \"Researcher\") group by SSN having count(employee.company_ID) >=3 
      order by SSN desc";
  
      foreach (DAOConstants::$pdo->query($sql) as $row) {
          echo '<li><p> SSN: ' .$row[0].' <br> First Name: '. $row[1].' <br> Last Name: '. $row[2].' <br> Citizenship: '. $row[3].' <br> Company Name: '. $row[4]. '</p></li>' ;  
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