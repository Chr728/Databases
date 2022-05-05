<?php
function autoloaderPhp($class){
    require("./" . $class . ".php");
  }
  spl_autoload_register("autoloaderPhp");
  DAOConstants::$pdo = new PDO("mysql:host=" . DAOConstants::host
    . "; port=3306; dbname=" . DAOConstants::dbname,
  DAOConstants::user, DAOConstants::password);
  DAOConstants::$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 

  
  ConstantValue::createHeader("Question 14");
  echo '<div class="main-center">';
  echo '<ul>';

  
  function CallQuery(){
    try{
     
      $sql = "select contactName, contractDate, product.name, purchase.quantity, concat(round(quantity*unitPrice,2), \" $\") as \"Contract Total Value\" from contract join purchase
      on contract.contract_ID = purchase.contract_ID join product on purchase.product_ID = product.UPC join pharmaCompany on 
      contract.company_ID = pharmaCompany.company_ID join client on contract.client_ID = client.client_ID where pharmaCompany.companyName = \"Pfizer\"";
      
      foreach (DAOConstants::$pdo->query($sql) as $row) {
          echo '<li><p> Name of Client: ' .$row[0].' <br> Contract Date: '. $row[1].' <br> Product Name: '. $row[2].' <br> Quantity Purchase: '. $row[3].' <br> Total Value of the Contract: '. $row[4]. '</p></li>' ;  
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