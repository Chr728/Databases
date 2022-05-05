<?php
    function autoloaderPhp($class){
    require("./" . $class . ".php");
  }
    spl_autoload_register("autoloaderPhp");
    DAOConstants::$pdo = new PDO("mysql:host=" . DAOConstants::host
    . "; port=3306; dbname=" . DAOConstants::dbname,
    DAOConstants::user, DAOConstants::password);
    DAOConstants::$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
    $sql = 'SELECT companyName FROM pharmaCompany where company_ID = ' . $_POST['company_ID'];
    $query = DAOConstants::$pdo->query($sql)->fetch();
  
    ConstantValue::createHeader("Question 1 Update");
    echo '<div class="main-center">';

?>

<form action="" method="post">
    <div class="form-select">
        <div>
            <label for="company_ID">Company ID: </label>
            <input name="company_ID" type="number" value="<?php echo $_POST['company_ID'] ?>" readonly>
        </div>
        <div>
            <label for="companyName">New Company Name: </label>
            <input name="companyName" type="text" value="<?php
                global $query;
                echo $query['companyName'];
             ?>" required>
        </div>
            <button class="indexB"><a href="1v.php">Back</a></button>
            <input type="submit" name="submit">
    </div>
</form>

<?php 
    function callQuery(){
        if(empty($_POST['companyName']) === false){
            try{
                $sql = 'update pharmaCompany set companyName = "' . $_POST['companyName'] . '" WHERE company_ID = ' . $_POST['company_ID'];
                DAOConstants::$pdo->query($sql);
                echo '<p class="success">Record updated successfully</p>';
            } catch(PDOException $e){
                echo '<div class="extra-space-large"></div>';
                Helper::printError($e);
                exit;
            }
        } else{
            echo '<div class = "error"><p> Warning: Please make sure the input fields are filled correctly</p></div>';
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
