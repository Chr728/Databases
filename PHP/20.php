<?php
function autoloaderPhp($class){
    require("./" . $class . ".php");
  }
  spl_autoload_register("autoloaderPhp");
  DAOConstants::$pdo = new PDO("mysql:host=" . DAOConstants::host
    . "; port=3306; dbname=" . DAOConstants::dbname,
  DAOConstants::user, DAOConstants::password);
  DAOConstants::$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 

  
  ConstantValue::createHeader("Question 20");
  echo '<div class="main-center">';
  echo '<ul>';

  function CallQuery(){
    try{
     
      $sql = "select companyName, year(contractDate), concat(round(sum(quantity*unitPrice),2), \" $\") as \"total sales\" from pharmaCompany
       join contract on pharmaCompany.company_ID = contract.company_ID
      join purchase on purchase.contract_ID = contract.contract_ID where year(contractDate) >= 2019 and year(contractDate) <= 2022 
      group by pharmaCompany.company_ID, year(contractDate) order by year(contractdate) desc, round(sum(quantity*unitPrice),2) desc";
   
      foreach (DAOConstants::$pdo->query($sql) as $row) {
          echo '<li><p> Company Name: ' .$row[0]. '<br> Year: '. $row[1].' <br> Total Sales: '. $row[2]. '</p></li>' ;  
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