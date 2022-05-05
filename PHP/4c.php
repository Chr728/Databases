<?php
function autoloaderPhp($class){
    require("./" . $class . ".php");
  }
  spl_autoload_register("autoloaderPhp");
  DAOConstants::$pdo = new PDO("mysql:host=" . DAOConstants::host
    . "; port=3306; dbname=" . DAOConstants::dbname,
  DAOConstants::user, DAOConstants::password);
  DAOConstants::$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
  
  ConstantValue::createHeader("Question 4 Create");
  echo '<div class="main-center">';
?>


<h2>Create Team Record</h2>

<form method="post">


         
    <div>
        <label for="teamName">Team Name:</label><input name="teamName" required>
    </div>

    <div>
    <label for="lead_SSN">SSN of leader:</label><input name="lead_SSN" required>
    </div>

    <button class="indexB"><a href="4.php">Back</a></button>
    <input type="submit" name="submit">
</form>

<?php 
    function callQuery(){
        if(empty($_POST['company_ID']) === FALSE  || empty($_POST['teamName']) === FALSE || empty($_POST['lead_SSN']) === FALSE   )
        {
            try{
                $sql = "INSERT INTO team (teamName,company_ID, lead_SSN,position)
                        VALUES ('" . $_POST['teamName'] . "', 1, '" . $_POST['lead_SSN'] . "',2);";
                DAOConstants::$pdo->query($sql);
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



