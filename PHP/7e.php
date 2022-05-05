


<?php
    function autoloaderPhp($class){
    require("./" . $class . ".php");
  }
    spl_autoload_register("autoloaderPhp");
    DAOConstants::$pdo = new PDO("mysql:host=" . DAOConstants::host
    . "; port=3306; dbname=" . DAOConstants::dbname,
    DAOConstants::user, DAOConstants::password);
    DAOConstants::$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
    $sql = 'SELECT * FROM client where  client_ID = ' . $_POST['client_ID'];
    $query = DAOConstants::$pdo->query($sql)->fetch();
  
    ConstantValue::createHeader("Question 7 Update");
    echo '<div class="main-center">';

?>

<form action="" method="post">
    <div class="form-select">
        <div>
            <label for="client_ID">Client ID: </label>
            <input name="client_ID" type="number" value="<?php echo $_POST['client_ID'] ?>" readonly>
        </div>
        <div>
            <label for="companyName">New Client Name: </label>
            <input  type="text" name="companyName" value="<?php
                global $query;
                echo $query['companyName'];
             ?>" required>
        </div>
        <div>
            <label for="contactName">New Contact name: </label>
           
            <input   type="text" name="contactName" value="<?php
                global $query;
                echo $query['contactName'];
             ?>" required>
        </div>
        <div>
            <label for="address">New address: </label>
            <input   type="text" name="address" value="<?php
                global $query;
                echo $query['address'];
             ?>" required>
        </div>
        <div>
            <label for=" city">New  city: </label>
            <input   type="text" name=" city" value="<?php
                global $query;
                echo $query['city'];
             ?>" required>
        </div>
        <div>
        <label for="province">Province:</label>
        <select name="province" id="provinceInfo">
            <?php 
                $sqlFetch = 'SELECT province FROM employee group by province order by province';
                foreach (DAOConstants::$pdo->query($sqlFetch) as $row) {
                        echo '<option value="'. $row[0] . '">' . $row[0] . '</option>';  
                }
            ?>
            </select>
        </div>

        
        <div>
            <label for="postalCode">New  postalCode: </label>
            <input   type="text" name="postalCode" value="<?php
                global $query;
                echo $query['postalCode'];
             ?>" required>
        </div>
        <div>
            <label for="country">New country: </label>
            <input   type="text" name="country" value="<?php
                global $query;
                echo $query['country'];
             ?>" required>
        </div>
        <div>
            <label for="phoneNumber">New phone Number: </label>
            <input   type="text" name="phoneNumber" value="<?php
                global $query;
                echo $query['phoneNumber'];
             ?>" required>
        </div>

        <div>
            <label for="email">New email: </label>
            <input   type="text" name="email" value="<?php
                global $query;
                echo $query['email'];
             ?>" required>
        </div>
            <button class="indexB"><a href="7v.php">Back</a></button>
            <input type="submit" name="submit">
    </div>
</form>

<?php 
    function callQuery(){
        if(empty($_POST['companyName']) === false || empty($_POST['contactName']) === false || empty($_POST['address']) === false || empty($_POST['city']) === false 
         || empty($_POST['postalCode']) === false || empty($_POST[' phoneNumber']) === false || empty($_POST['email']) === false
        ){
            try{
                $sql = 'update client set companyName = "' . $_POST['companyName'] .  '" ,contactName = "' . $_POST['contactName'] .  
                '" ,address= "' . $_POST['address'] .  '" ,city = "' . $_POST['city'] .  '" ,province = "' . $_POST['province'] .  '" 
                ,postalCode = "' . $_POST['postalCode'] .  '" ,phoneNumber = "' . $_POST['phoneNumber'] .  '" ,email = "' . $_POST['email'] .  '"
                             WHERE client_ID = ' . $_POST['client_ID'];
                DAOConstants::$pdo->query($sql);
                echo '<p class="success">Record updated successfully</p>';
            } catch(PDOException $e){
                echo '<div class="extra-space-large"></div>';
                Helper::printError($e);
                exit;
            }
        } 
        
       
        
        else{
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
