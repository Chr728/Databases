<?php
function autoloaderPhp($class){
    require("./" . $class . ".php");
  }
  spl_autoload_register("autoloaderPhp");
  DAOConstants::$pdo = new PDO("mysql:host=" . DAOConstants::host
  . "; port=3306; dbname=" . DAOConstants::dbname,
  DAOConstants::user, DAOConstants::password);
  DAOConstants::$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 

  
  ConstantValue::createHeader("Question 1 View");
  echo '<div class="main-center">';
?>

<form action="1e.php" method="post" id="post">
    <div class="form-select">
        <label for="company_ID"> Company: </label>
        <select name="company_ID" id="companyInfo">
    <?php 
        $sqlFetch = 'SELECT companyName, company_ID FROM pharmaCompany order by companyName';
        foreach (DAOConstants::$pdo->query($sqlFetch) as $row) {
                echo '<option value='. $row[1] . '>' . $row[0] . '</option>';  
            }
    ?>
        </select>
    </div>
    <button class="indexB"><a href="1.php">Back</a></button>
    <input type="submit" name="update" value="Update/View"/>
    <input type="submit" name="delete" value="Delete" formaction=""/>
</form>
    
<?php 
    function deleteItem(){
        try{
            $sql = 'delete from pharmaCompany where company_ID = ' . $_POST['company_ID'];
            DAOConstants::$pdo->query($sql);
            echo '<p class="success">Record deleted successfully</p>';
        } catch(PDOException $e){
            echo '<div class="extra-space-large"></div>';
            Helper::printError($e);
            exit;
        }
    }

    if(array_key_exists('delete', $_POST))
        deleteItem();

    echo '<div class="extra-space-large"></div>';
    echo ConstantValue::footer;
?>









