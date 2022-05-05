<?php
function autoloaderPhp($class){
    require("./" . $class . ".php");
  }
  spl_autoload_register("autoloaderPhp");
  DAOConstants::$pdo = new PDO("mysql:host=" . DAOConstants::host
  . "; port=3306; dbname=" . DAOConstants::dbname,
  DAOConstants::user, DAOConstants::password);
  DAOConstants::$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
  ConstantValue::createHeader("Question 9");
?>

<div class="main-center">
  <h2>Question 9</h3>
  <h4>Please input the new CEO's ssn and their company id</h4>
  <form action = "" method="POST">
    <p><p class="infoRequest">CEO's SSN: </p><input type="text" name="ssn" value=""></p>
    <p><p class="infoRequest">Company's ID: </p><input type="text" name="cid" value=""></p>
    <input type="submit" name="submit" value="Submit">
  </form>


<?php
  $queryOne = null;
  $queryTwo = null;
  $queryThree = null;

  function verifyErrors(){
    // Initially had triggers, changed to this due to invalid php version
    global $queryOne, $queryTwo, $queryThree;
    $queryOne = Helper::verifyQuery(DAOConstants::$pdo, 'select count(SSN) from employee where SSN = ' . trim($_POST['ssn']) . ' limit 1', ">", 0);
    $queryTwo = Helper::verifyQuery(DAOConstants::$pdo, 'select ' . trim($_POST['cid']) . ' not in (select pharmaCompany.company_ID from pharmaCompany) from pharmaCompany limit 1', "<", 1);
    if ($queryOne === false){
      return false;
    }
    $queryThree = Helper::verifyQuery(DAOConstants::$pdo, 'select ' . trim($_POST['ssn']) . ' not in (select CEO_SSN from headOffice) from headOffice where company_ID = ' . trim($_POST['cid']) . ' limit 1', ">", 0);
      $returnResult = ($queryOne  !== false && $queryTwo  !== false && $queryThree  !== false);
      return $returnResult;
  }
  
  function CallQuery(){
    global $queryOne, $queryTwo, $queryThree;
    if(!empty($_POST['ssn']) && !empty($_POST['cid']) && is_numeric($_POST['cid']) && is_numeric($_POST['ssn'])){
      if(verifyErrors()){
          try{
            $db_manipulation_1 = 'update employee set endDate = current_date() where (endDate >= current_date() or endDate is null) and employee.SSN = ' . trim($_POST['ssn'] . ' and company_ID = ' . trim($_POST['cid']));
            DAOConstants::$pdo->query($db_manipulation_1); 
          } catch(PDOException $e){
            Helper::printError($e);
          }
          try{
            $db_manipulation_2 = 'insert into employee values (' . trim($_POST['cid']) . ', ' . trim(trim($_POST['ssn'])) . ', (select position_ID from jobPosition where jobTitle="CEO"), 
            (select firstName from (select firstName from employee where SSN = ' . trim($_POST['ssn']) . ' limit 1) as fname),
            (select lastName from (select lastName from employee where SSN = ' . trim($_POST['ssn']) . ' limit 1) as lname),
            (select dateOfBirth from (select dateOfBirth from employee where SSN = ' . trim($_POST['ssn']) . ' limit 1) as dot),
            (select citizenship from (select citizenship from employee where SSN = ' . trim($_POST['ssn']) . ' limit 1) as ct),
            (select address from (select address from employee where SSN = ' . trim($_POST['ssn']) . ' limit 1) as ad),
            (select city from (select city from employee where SSN = ' . trim($_POST['ssn']) . ' limit 1) as cy),
            (select province from (select province from employee where SSN = ' . trim($_POST['ssn']) . ' limit 1) as pr),
            (select postalCode from (select postalCode from employee where SSN = ' . trim($_POST['ssn']) . ' limit 1) as ps),
            (select country from (select country from employee where SSN = ' . trim($_POST['ssn']) . ' limit 1) as co),
            (select phoneNumber from (select phoneNumber from employee where SSN = ' . trim($_POST['ssn']) . ' limit 1) as pn),
            (select email from (select email from employee where SSN = ' . trim($_POST['ssn']) . ' limit 1) as em),
            (select salary from (select salary from employee where SSN = ' . trim($_POST['ssn']) . ' limit 1) as sy),
            (select headOffice.facility_ID from headOffice join pharmaCompany on headOffice.company_ID = pharmaCompany.company_ID 
            where pharmaCompany.company_ID = ' . trim($_POST['cid']) . '), current_date(), null)';
            $db_manipulation_3 = 'Update headOffice set CEO_SSN = ' . trim($_POST['ssn']) . ', email = (select email from employee where SSN = ' . trim($_POST['ssn']) . ' limit 1) where company_ID = ' . trim($_POST['cid']);
            DAOConstants::$pdo->query($db_manipulation_2);
            DAOConstants::$pdo->query($db_manipulation_3);
          }catch(PDOException $e){
            Helper::printError($e);
          }
          echo '<p class="success"> Task has been completed successfully, new CEO with ID ' . trim(trim($_POST['ssn'])) . ' has been added to company ' . trim($_POST['cid']) . ' and a new Employee entry has been created for him</p>';
        }
        else{
          Helper::verifyBooleans([$queryOne, $queryTwo, $queryThree], ['No Employee with that SSN exists', 'No Company with that ID exists', 'The employee is already CEO of this company']);
          exit;
        }
    }else{
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
