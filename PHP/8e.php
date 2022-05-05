<?php
    function autoloaderPhp($class){
    require("./" . $class . ".php");
  }
    spl_autoload_register("autoloaderPhp");
    DAOConstants::$pdo = new PDO("mysql:host=" . DAOConstants::host
    . "; port=3306; dbname=" . DAOConstants::dbname,
    DAOConstants::user, DAOConstants::password);
    DAOConstants::$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $sql = 'SELECT clientname, contractDate, deliveryDate FROM contract where contract_ID = ' . $_POST['contract_ID'];
    $query = DAOConstants::$pdo->query($sql)->fetch();
    ConstantValue::createHeader("Question 8 Update");
    echo '<div class="main-center">';   
?>

<form action="" method="post">
    <div class="form-select">
        <div>
            <label for="project_ID">Contract ID: </label>
            <input name="contract_ID" type="number" value="<?php echo $_POST['contract_ID'] ?>" readonly>
        </div>
        <div>
            <label for="clientName">New Client Name: </label>
            <input name="clientName" value="<?php
                global $query;
                echo $query['clientname'];
             ?>" required  type="text" >
        </div>
        <div>
            <label for="contractDate">New Contract Date: </label>
            <input name="contractDate" value="<?php
                global $query;
                echo $query['contractDate'];
             ?>" required type="date" >
        </div>
        <div>
            <label for="deliveryDate">New Delivery Date: </label>
            <input name="deliveryDate" value="<?php
                global $query;
                echo $query['deliveryDate'];
             ?>" required type="date" >
        </div>
            <button class="indexB"><a href="8v.php">Back</a></button>
            <input type="submit" name="submit">
    </div>
</form>

<?php
    function callQuery(){
        if((empty($_POST['clientName']) === false)
        && (empty($_POST['contractDate']) === false)
        && (empty($_POST['deliveryDate']) === false)){
            try{
                $sql = 'update contract set clientName = "' . $_POST['clientName'] . '", contractDate = "' . $_POST['contractDate'] . '",
                deliveryDate = "' . $_POST['deliveryDate'] . '" WHERE contract_ID = ' . $_POST['contract_ID'];
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
