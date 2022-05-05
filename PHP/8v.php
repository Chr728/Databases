<?php
function autoloaderPhp($class){
    require("./" . $class . ".php");
  }
  spl_autoload_register("autoloaderPhp");
  DAOConstants::$pdo = new PDO("mysql:host=" . DAOConstants::host
  . "; port=3306; dbname=" . DAOConstants::dbname,
  DAOConstants::user, DAOConstants::password);
  DAOConstants::$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);


  ConstantValue::createHeader("Question 8 View");
  echo '<div class="main-center">';
?>

<form action="8e.php" method="post" id="post">
    <div class="form-select">
        <label for="clientName"> Contract: </label>
        <select name="contract_ID" id="projectInfo">
    <?php
        $sqlFetch = 'SELECT clientName, contract_ID FROM contract order by clientName';
        foreach (DAOConstants::$pdo->query($sqlFetch) as $row) {
                echo '<option value='. $row[1] . '>' . $row[0] . '</option>';
            }
    ?>
        </select>
    </div>
    <button class="indexB"><a href="8.php">Back</a></button>
    <input type="submit" name="update" value="update"/>
    <input type="submit" name="delete" value="delete" formaction=""/>
</form>

<?php
    function callQuery(){
            try{
            $sql = 'SELECT *
            FROM contract
            WHERE contract_ID = ' . $_POST['contract_ID'];
            DAOConstants::$pdo->query($sql);
        } catch(PDOException $e){
            echo '<div class="extra-space-large"></div>';
            Helper::printError($e);
            exit;
        }
    }

    function deleteItem(){
        try{
            $sql = 'delete from contract where contract_ID = ' . $_POST['contract_ID'];
            DAOConstants::$pdo->query($sql);
            echo '<p class="success">Record deleted successfully</p>';
        } catch(PDOException $e){
            echo '<div class="extra-space-large"></div>';
            Helper::printError($e);
            exit;
        }
    }

    if (isset($_POST['submit'])){
        callQuery();
  }
    if(array_key_exists('delete', $_POST))
        deleteItem();

    echo '<div class="extra-space-large"></div>';
    echo ConstantValue::footer;
?>
