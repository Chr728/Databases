<?php
    function autoloaderPhp($class){
    require("./" . $class . ".php");
  }
    spl_autoload_register("autoloaderPhp");
    DAOConstants::$pdo = new PDO("mysql:host=" . DAOConstants::host
    . "; port=3306; dbname=" . DAOConstants::dbname,
    DAOConstants::user, DAOConstants::password);
    DAOConstants::$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
  
    ConstantValue::createHeader("Question 2 Update");
    echo '<div class="main-center">';
    $query = 'select * from employee where SSN =' . $_POST['SSN'] . ' and endDate IS null OR endDate > current_date()  ';
    $result = DAOConstants::$pdo->query($query)->fetch();
?>

<form action="" method="post">
    <div class="form-select">
        <div>
            <label for="company_ID">Company ID:</label><input type="text" name="company_ID"  value="<?= $_POST['company_ID']?>" readonly>
        </div>

        <div>
            <label for="firstName">First Name:</label><input type="text"  name="firstName" value="<?= $result['firstName']?>" required>
        </div>

        <div>
            <label for="lastName">Last Name: </label><input type="text" name="lastName" value="<?= $result['lastName']?>" required>
        </div>

        <div>
            <label for="dateOfBirth">Date of Birth:</label><input type="text"  name="dateOfBirth" value="<?= $result['dateOfBirth']?>" required>
        </div>

        <div>
            <label for="SSN">SSN:</label><input type="text"  name="SSN" type="number" value="<?= $_POST['SSN']?>" readonly>
        </div>

        <div>
            <label for="citizenship">Citizenship:</label><input type="text"  name="citizenship"  value="<?= $result['citizenship']?>" required>
        </div>

        <div>
            <label for="address">Address:</label><input type="text"  name="address" value="<?= $result['address']?>" required>
        </div>

        <div>
            <label for="city">City:</label><input type="text"  name="city" value="<?= $result['city']?>" required>
        </div>

        <div>
            <label for="province">Province:</label><input type="text"  name="province" value="<?= $result['province']?>" required>
        </div>

        <div>
            <label for="postalCode">Postal Code:</label><input type="text"  name="postalCode" value="<?= $result['postalCode']?>" required>
        </div>

        <div>
            <label for="country">Country:</label><input type="text"  name="country" value="<?= $result['country']?>" required>
        </div>

        <div>
            <label for="phoneNumber">Phone Number:</label><input type="text"  name="phoneNumber" value="<?= $result['phoneNumber']?>" required>
        </div>

        <div>
            <label for="email">Email:</label><input type="text"  name="email" value="<?= $result['email']?>" required>
        </div>

        <div>
            <label for="position">Position:</label><input type="text"  name="position" value="<?= $result['position']?>" required>
        </div>

        <div>
            <label for="salary">Salary:</label><input type="text"  name="salary" type="number" value="<?= $result['salary']?>" required>
        </div>

        <div>
            <label for="facility">Facility:</label><input  type="text" name="facility" value="<?= $result['facility']?>" required>
        </div>

        <div>
            <label for="startDate">Start Date:</label><input  type="date" name="startDate" value="<?= $result['startDate']?>" required>
        </div>

        <div>
            <label for="endDate">End Date:</label><input type="date"  name="endDate" value="<?= $result['endDate']?>" >
        </div>
        <button class="indexB" ><a href="3v.php">Back</a></button>
        <input type="submit" name="Save">

    </div>
</form>

<?php 
    function callQuery(){
        $sql = null;
        $verificaiton = 'select SSN from employee where company_ID = ' . $_POST['company_ID'] . ' and SSN = ' . $_POST['SSN'];
        $result = DAOConstants::$pdo->query($verificaiton)->fetch();
        if($result !== false){
            try{
                if(empty($_POST['endDate']))
                    $sql = 'update employee set firstName = "' . $_POST['firstName'] . '", lastName = "' . $_POST['lastName'] . '", dateOfBirth = "' . $_POST['dateOfBirth'] . '", citizenship = "' . $_POST['citizenship'] . '", address = "' . $_POST['address'] . '", city = "' . $_POST['city'] . '", province = "' . $_POST['province'] . '", postalCode = "' . $_POST['postalCode'] . '", country = "' . $_POST['country'] . '",  phoneNumber = "' . $_POST['phoneNumber'] . '", email = "' . $_POST['email'] . '", position = ' . $_POST['position'] . ', salary = ' . $_POST['salary'] . ',  facility = ' . $_POST['facility'] . ', startDate = "' . $_POST['startDate'] . '" where company_ID = ' . $_POST['company_ID'] . ' and SSN = ' . $_POST['SSN'] . ' and (endDate is null or endDate > current_date())';
                else
                    $sql = 'update employee set firstName = "' . $_POST['firstName'] . '", lastName = "' . $_POST['lastName'] . '", dateOfBirth = "' . $_POST['dateOfBirth'] . '", citizenship = "' . $_POST['citizenship'] . '", address = "' . $_POST['address'] . '", city = "' . $_POST['city'] . '", province = "' . $_POST['province'] . '", postalCode = "' . $_POST['postalCode'] . '", country = "' . $_POST['country'] . '",  phoneNumber = "' . $_POST['phoneNumber'] . '", email = "' . $_POST['email'] . '", position = ' . $_POST['position'] . ', salary = ' . $_POST['salary'] . ',  facility = ' . $_POST['facility'] . ', startDate = "' . $_POST['startDate'] . '", endDate = "' . $_POST['endDate'] . '" where company_ID = ' . $_POST['company_ID'] . ' and SSN = ' . $_POST['SSN'] . ' and (endDate is null or endDate > current_date())';
                $query = DAOConstants::$pdo->query($sql)->fetch();
                echo '<p class="success">Record updated successfully</p>';
            } catch(PDOException $e){
                echo '<div class="extra-space-large"></div>';
                Helper::printError($e);
                exit;
            }
        }else{
            echo '<div class="extra-space-large"></div>';
            echo '<div class = "error"><p> Warning: The Employee record you chose is incompatible with the company you chose</p></div>';
            echo ConstantValue::footer;
            exit;
        }

    }   

if (isset($_POST['Save'])){
    CallQuery();
  }


    echo '<div class="extra-space-large"></div>';
    echo ConstantValue::footer;
?>