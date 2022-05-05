<?php
    function autoloaderPhp($class){
    require("./" . $class . ".php");
  }
    spl_autoload_register("autoloaderPhp");
    DAOConstants::$pdo = new PDO("mysql:host=" . DAOConstants::host
    . "; port=3306; dbname=" . DAOConstants::dbname,
    DAOConstants::user, DAOConstants::password);
    DAOConstants::$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
    $sql = 'SELECT * FROM facility where  facility_ID = ' . $_POST['facility_ID'];
    $query = DAOConstants::$pdo->query($sql)->fetch();
  
    ConstantValue::createHeader("Question 2 Update");
    echo '<div class="main-center">';

?>

<form action="" method="post">
    <div class="form-select">
        
        <div>
            <label for=" facility_ID">Facility ID: </label>
            <input name=" facility_ID" type="number" value="<?php echo $_POST['facility_ID'] ?>" readonly>
        </div>
        <div>
            <label for="facilityName">New Facility Name: </label>
            <input name="facilityName" type="text" value="<?php
                global $query;
                echo $query['facilityName'];
             ?>" required>
        </div>

        <div>
            <label for="facilityType">Facility Type:</label>
            <select name="facilityType" id="facilityTypeInfo">
                <?php 
                    global $query;
                    $sqlFetch = 'SELECT facilityType FROM facility group by facilityType order by facilityType';
                    foreach (DAOConstants::$pdo->query($sqlFetch) as $row) {
                            if($row[0] === $query['facilityType'])
                                echo '<option selected = "selected" value="'. $row[0] . '">' . $row[0] . '</option>';  
                            else
                                echo '<option value="'. $row[0] . '">' . $row[0] . '</option>';  
                        }
                ?>
            </select>
        </div>
        <div>
            <label for="facilityType">Facility Type:</label>
           
            <input name="facilityType" type="text" value="<?php
                global $query;
                echo $query['facilityType'];
             ?>" required>
        </div>
        <div>
            <label for="address">New address: </label>
            <input name="address" type="text" value="<?php
                global $query;
                echo $query['address'];
             ?>" required>
        </div>
        <div>
            <label for=" city">New  city: </label>
            <input name=" city" type="text" value="<?php
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
                        if($row[0] === $query['province'])
                        echo '<option selected = "selected" value="'. $row[0] . '">' . $row[0] . '</option>';  
                    else
                        echo '<option value="'. $row[0] . '">' . $row[0] . '</option>';  
                    }
                ?>
            </select>
        </div>

        
        <div>
            <label for="postalCode">New Postal Code: </label>
            <input name="postalCode" type="text" value="<?php
                global $query;
                echo $query['postalCode'];
             ?>" required>
        </div>
        <div>
            <label for="country">New country: </label>
            <input name="country" type="text" value="<?php
                global $query;
                echo $query['country'];
             ?>" required>
        </div>
        <div>
            <label for="phoneNumber">New phone Number: </label>
            <input name="phoneNumber" type="text" value="<?php
                global $query;
                echo $query['phoneNumber'];
             ?>" required>
        </div>
    


            <button class="indexB"><a href="2v.php">Back</a></button>
            <input type="submit" name="submit">
    </div>
</form>

<?php 
    function callQuery(){
        if(empty($_POST['facilityName']) === false || empty($_POST['facilityType']) === false || empty($_POST['address']) === false || empty($_POST['city']) === false 
         || empty($_POST['province']) === false || empty($_POST['postalCode']) === false || empty($_POST[' phoneNumber']) === false
        ){
            try{
                $sql = 'update facility set facilityName = "' . $_POST['facilityName'] .  '" ,facilityType = "' . $_POST['facilityType'] .  
                '" ,address= "' . $_POST['address'] .  '" ,city = "' . $_POST['city'] .  '" ,province = "' . $_POST['province'] .  '" 
                ,postalCode = "' . $_POST['postalCode'] .  '" ,phoneNumber = "' . $_POST['phoneNumber'] .  '" 
                             WHERE facility_ID = ' . $_POST['facility_ID'];
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
