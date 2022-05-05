<?php
function autoloaderPhp($class){
    require("./" . $class . ".php");
  }
  spl_autoload_register("autoloaderPhp");
  DAOConstants::$pdo = new PDO("mysql:host=" . DAOConstants::host
    . "; port=3306; dbname=" . DAOConstants::dbname,
  DAOConstants::user, DAOConstants::password);
  DAOConstants::$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 

  
  ConstantValue::createHeader("Question 17");
  echo '<div class="main-center">';
  echo '<ul>';

  function CallQuery(){
    try{
     
      $sql = "select firstName, lastName, email, sum(totalHours) as \"hours worked\" from employee join pharmaCompany on employee.company_ID = pharmaCompany.company_ID join
      researchAssignment on researchAssignment.researcher_SSN = employee.SSN where pharmaCompany.companyName = \"pfizer\" group by SSN";
  
      foreach (DAOConstants::$pdo->query($sql) as $row) {
          echo '<li><p> First Name: ' .$row[0].' <br> Last Name: '. $row[1].' <br> Email: '. $row[2].' <br> Hours Worked on all Projects: '. $row[3]. '</p></li>' ;  
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