<?php
function autoloaderPhp($class){
    require("./" . $class . ".php");
  }
  spl_autoload_register("autoloaderPhp");
  DAOConstants::$pdo = new PDO("mysql:host=" . DAOConstants::host
    . "; port=3306; dbname=" . DAOConstants::dbname,
  DAOConstants::user, DAOConstants::password);
  DAOConstants::$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 

  
  ConstantValue::createHeader("Question 10");
?>

<div class="main-center">
  <h3>Please input the Researcher's ssn, the Company's name, and the Project Number</h3>  
<form action = "" method="POST">
  <p><p class="infoRequest">Researcher's ssn: </p><input type="text" name="ssn" value=""></p>
  <p><p class="infoRequest">Company's id: </p><input type="text" name="cid" value=""></p>
  <p><p class="infoRequest">Project Number: </p><input type="text" name="pnumber" value=""></p>
  <input type="Submit" name="submit" value="Submit">
</form>
<?php

  $queryOne = null;
  $queryTwo = null;
  $queryThree = null;
  $queryFour = null;
  $queryFive = null;
  $querySix = null;
  $querySeven = null;

  function verifyErrors(){
    // Initially had triggers, changed to this due to invalid php version
    global $queryOne, $queryTwo, $queryThree, $queryFour, $queryFive, $querySix, $querySeven;
    $queryOne = Helper::verifyQuery(DAOConstants::$pdo, 'select ' . $_POST['ssn'] . ' not in (select employee.SSN from employee) from employee limit 1', "<", 1);
    $queryTwo = Helper::verifyQuery(DAOConstants::$pdo, 'select ' . $_POST['cid'] . ' not in (select pharmaCompany.company_ID from pharmaCompany) from pharmaCompany limit 1', "<", 1);
    $queryThree = Helper::verifyQuery(DAOConstants::$pdo, 'select ' . $_POST['pnumber'] . ' not in (select project_ID from project) from project limit 1', "<", 1);
    if($queryOne == false || $queryTwo === false || $queryThree === false){
      return false;
    }
    $queryFour = Helper::verifyQuery(DAOConstants::$pdo, 'select ' . $_POST['ssn'] . ' not in (select employee.SSN from employee where position=(select position_ID from jobPosition where jobTitle="Researcher")) from employee limit 1', "<", 1);
      if($queryFour === false){
        return false;
      }
      $queryFive = Helper::verifyQuery(DAOConstants::$pdo, 'select ' . $_POST['ssn']. ' in (select employee.SSN from employee where (endDate > current_Date() or endDate is null) and SSN = ' . $_POST['ssn'] .') from employee order by (CASE WHEN endDate IS NULL THEN current_date() ELSE endDate END) DESC limit 1', ">", 0);
      if($queryFive === false){
        return false;
      }
      $querySix = Helper::verifyQuery(DAOConstants::$pdo, 'select ' . $_POST['cid'] . ' not in (select pharmaCompany.company_ID from pharmaCompany join employee on pharmaCompany.company_ID = employee.company_ID where SSN = ' . $_POST['ssn'] . ' and (endDate > current_Date() or endDate is null)) from pharmaCompany limit 1', "<", 1);
      if($querySix === false){
        return false;
      }
      $querySeven = Helper::verifyQuery(DAOConstants::$pdo, 'select ' . $_POST['ssn'] . ' in (select researcher_SSN from researchAssignment where researcher_SSN = ' . $_POST['ssn'] . ' and project_ID = ' . $_POST['pnumber'] . ' and company_ID = ' . $_POST['cid'] .') from researchAssignment order by (CASE WHEN endDate IS NULL THEN current_date() ELSE endDate END) DESC limit 1', "<", 1);
      $returnResult = ($queryOne !== false && $queryTwo !== false && $queryThree !== false && $queryFour !== false && $queryFive !== false && $querySix !== false && $querySeven !== false);
      return $returnResult;
  }

  
  function CallQuery(){
    if(is_numeric($_POST['cid']) && is_numeric($_POST['ssn']) && is_numeric($_POST['pnumber'])){
      global $queryOne, $queryTwo, $queryThree, $queryFour, $queryFive, $querySix, $querySeven;
      if(verifyErrors()){
        try{
          $sql = 'Insert into researchAssignment values(' . $_POST['pnumber'] . ', ' . $_POST['cid'] . ', ' . $_POST['ssn'] . ', (select position_ID from jobPosition where jobTitle="Researcher"), current_date(), null, 0)';
          DAOConstants::$pdo->query($sql);
          echo '<p class="success"> Task has been completed successfully, new Researcher ' . $_POST['ssn'] . ' who works for company ' . $_POST['cid'] . ' has been added to project ' . $_POST['pnumber'] . '</p>';

        } catch(PDOException $e){
          Helper::printError($e);
        }
      } else{
        Helper::verifyBooleans([$queryOne, $queryTwo, $queryThree, $queryFour, $queryFive, $querySix, $querySeven], 
        ['No Employee with that SSN exists', 'No Company with that ID exists', 'No Project with that ID exists', 'Employee with this SSN is not a Researcher', 'Employee no longer works here',
        'Researcher does not work for this company', 'Employee is already a member of this project']);
        exit;
      }
    } else{
            echo '<div class = "error"><p> Warning: Please only enter numbers in the input fields</p></div>';
            echo ConstantValue::footer;
            exit;
      }
  }

  if (isset($_POST['submit'])){
    CallQuery();
  }
  
  echo ConstantValue::footer;
?>