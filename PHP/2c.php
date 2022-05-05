<?php
function autoloaderPhp($class){
    require("./" . $class . ".php");
  }
  spl_autoload_register("autoloaderPhp");
  DAOConstants::$pdo = new PDO("mysql:host=" . DAOConstants::host
    . "; port=3306; dbname=" . DAOConstants::dbname,
  DAOConstants::user, DAOConstants::password);
  DAOConstants::$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
  
  ConstantValue::createHeader("Question 2 Create");
  echo '<div class="main-center">';
?>


<h2>Create Facility Record</h2>

<form method="post">

    <div class="form-select">
        <div>
                <label for="company_ID"> Company: </label>
                <select name="company_ID" id="companyInfo">
                    <?php 
                        $sqlFetch = 'SELECT companyName, company_ID FROM pharmaCompany order by companyName';
                        foreach (DAOConstants::$pdo->query($sqlFetch) as $row) {
                                echo '<option value="'. $row[1] . '">' . $row[0] . '</option>';  
                            }
                    ?>
                </select>
            </div>
        <div>
        <label for="facilityName">Facility Name:</label><input name="facilityName" class="weird-margin-error" type="text" required/>
        </div>

        <div>
            <label for="facilityType">Facility Type:</label>
            <select name="facilityType" id="facilityTypeInfo">
                <?php 
                    $sqlFetch = 'SELECT facilityType FROM facility group by facilityType order by facilityType';
                    foreach (DAOConstants::$pdo->query($sqlFetch) as $row) {
                            echo '<option value="'. $row[0] . '">' . $row[0] . '</option>';  
                        }
                ?>
            </select>
        </div>

        <div>
            <label for="address">Address:</label><input name="address" class="weird-margin-error" type="text" required/>
        </div>

        <div>
            <label for="city">City:</label><input name="city" class="weird-margin-error" type="text" required/>
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
            <label for="postalCode">Postal Code:</label><input name="postalCode" class="weird-margin-error" type="text" required/>
        </div>

        <div>
            <label for="country">Country:</label><input name="country" class="weird-margin-error" type="text" required/>
        </div>

        <div>
            <label for="phoneNumber">Phone Number:</label><input name="phoneNumber" class="weird-margin-error" type="text" required/>
        </div>

        <button class="indexB"><a href="2.php">Back</a></button>
        <input type="submit" name="submit">
    <div>
</form>

<?php 
    function callQuery(){
        echo $_POST['facilityType'];
        if(empty($_POST['company_ID']) === FALSE   || empty($_POST['address']) === FALSE || empty($_POST['city']) === FALSE    
        ||  empty($_POST['postalCode']) === FALSE    ||    empty($_POST['country']) === FALSE  || empty($_POST['phoneNumber']) === FALSE  ){
            try{
                $sql = "INSERT INTO facility (facilityName,company_ID, facilityType, address, city, province, postalCode, country, phoneNumber)
                        VALUES ('" . $_POST['facilityName'] . "', '" . $_POST['company_ID'] . "', '" . $_POST['facilityType'] . "',
                                '" . $_POST['address'] . "', '" . $_POST['city'] . "', '" . $_POST['province'] . "', 
                                '" . $_POST['postalCode'] . "', '" . $_POST['country'] . "', '" . $_POST['phoneNumber'] . "');";
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