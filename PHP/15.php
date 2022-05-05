<?php
function autoloaderPhp($class){
    require("./" . $class . ".php");
  }
  spl_autoload_register("autoloaderPhp");
  DAOConstants::$pdo = new PDO("mysql:host=" . DAOConstants::host
    . "; port=3306; dbname=" . DAOConstants::dbname,
  DAOConstants::user, DAOConstants::password);
  DAOConstants::$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 

  
  ConstantValue::createHeader("Question 15");
  echo '<div class="main-center">';
  echo '<ul>';

  
  function CallQuery(){
    try{
     
      $sql = "select contract.clientName, pharmaCompany.companyName as \"Pharmaceutical Company\", contract.contractDate, product.name,
      sum(purchase.quantity) as \"Quantity\", sum(purchase.quantity*purchase.unitPrice) as \"Contract Value\"
      from contract
      join client on contract.client_ID = client.client_ID
      join pharmaCompany on contract.company_ID = pharmaCompany.company_ID
      join  purchase on contract.contract_ID = purchase.contract_ID
      join product on purchase.product_ID = product.UPC
      group by contract.contract_ID ORDER BY ROUND(SUM(purchase.quantity*purchase.unitPrice), 2) DESC";
  
      foreach (DAOConstants::$pdo->query($sql) as $row) {
        echo '<li><p> Client Name: ' .$row[0].' <br> Company Name: '. $row[1].' <br> Contract Date: '. $row[2].' <br> Product Name: '. $row[3].' <br> Quantity Purchased: '. $row[4].' <br> Total Value of the Contract: '. $row[5]. '</p></li>' ;  
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