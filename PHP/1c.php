<?php
function autoloaderPhp($class){
    require("./" . $class . ".php");
  }
  spl_autoload_register("autoloaderPhp");
  DAOConstants::$pdo = new PDO("mysql:host=" . DAOConstants::host
  . "; port=3306; dbname=" . DAOConstants::dbname,
  DAOConstants::user, DAOConstants::password);
  DAOConstants::$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 

  
  ConstantValue::createHeader("Question 1 Create");
  echo '<div class="main-center">';
?>


<h2>Create Company Record</h2>

<form method="post">

    <div>
        Company Name: <input name="companyName">
    </div>
    <button class="indexB"><a href="1.php">Back</a></button>
    <input type="submit" name="submit">
</form>

<?php 
    function callQuery(){
        if(empty($_POST['companyName']) === FALSE){
            try{
                $sql = 'insert into pharmaCompany(companyName) values ("'. $_POST['companyName'] . '")';
                $query = DAOConstants::$pdo->query($sql);
                echo '<p class="success">New record entered successfully</p>';
            } catch(PDOException $e){
                echo '<div class="extra-space-mediumLarge"></div>';
                Helper::printError($e);
                exit;
            }
        } else{
            echo '<div class="extra-space-mediumLarge"></div>';
            echo '<div class = "error"><p> Warning: Please enter a value in the input field</p></div>';
            echo ConstantValue::footer;
            exit;
        }
    }

if (isset($_POST['submit'])){
    CallQuery();
  }
    echo '<div class="extra-space-large"></div>';
    echo ConstantValue::footer;
?>


