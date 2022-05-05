<?php
function autoloaderPhp($class){
    require("./" . $class . ".php");
  }
  spl_autoload_register("autoloaderPhp");
  DAOConstants::$pdo = new PDO("mysql:host=" . DAOConstants::host
  . "; port=3306; dbname=" . DAOConstants::dbname,
  DAOConstants::user, DAOConstants::password);
  DAOConstants::$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 

  
  ConstantValue::createHeader("Question 3 Create");
  echo '<div class="main-center">';
?>

<h2>Create Employee Record</h2>

<form method="post">

    <div>
        <label for="company_ID">Facility:</label>
        <select name="company_ID" id="company_ID_Info">
                <?php 
                    $sqlFetch = 'SELECT companyName, company_ID FROM pharmaCompany order by companyName';
                    foreach (DAOConstants::$pdo->query($sqlFetch) as $row) {
                            echo '<option value="'. $row[1] . '">' . $row[0] . '</option>';  
                        }
                ?>
        </select>
    </div>

    <div>
        <label for="SSN">SSN:</label><input name="SSN"  class="weird-margin-error" type="number" required>
    </div>

    <div>
        <label for="firstName">First Name:</label><input name="firstName"  class="weird-margin-error" type="text" required>
    </div>

    <div>
        <label for="lastName">Last Name:</label><input name="lastName" type="text"  class="weird-margin-error"  required>
    </div>

    <div>
        <label for="dateOfBirth">Date Of Birth:</label><input name="dateOfBirth"  type="date" class="weird-margin-error"  required>
    </div>

    <div>
        <label for="citizenship">Citizenship:</label><input name="citizenship"  type="text" class="weird-margin-error"  required>
    </div>

    <div>
        <label for="address">Address:</label><input name="address"  type="text"  class="weird-margin-error" required>
    </div>

    <div>
        <label for="city">City:</label><input name="city"  type="text" class="weird-margin-error"  required>
    </div>

    <div>
        <label for="postalCode">Postal Code:</label><input name="postalCode"  type="text" class="weird-margin-error"  required>
    </div>

    <div>
        <label for="country">Country:</label><input name="country"  type="text" class="weird-margin-error"  required>
    </div>

    <div>
        <label for="phoneNumber">Phone Number:</label><input name="phoneNumber" type="text"  class="weird-margin-error" required>
    </div>

    <div>
        <label for="email">Email:</label><input name="email"  type="text" class="weird-margin-error"  required>
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
        <label for="salary">Salary:</label><input name="salary"  type="number" class="weird-margin-error"  required>
    </div>

    <div>
        <label for="position">Position:</label>
        <select name="position" id="positionInfo">
                <?php 
                    $sqlFetch = 'SELECT jobTitle, position_ID FROM jobPosition order by jobTitle';
                    foreach (DAOConstants::$pdo->query($sqlFetch) as $row) {
                            echo '<option value="'. $row[1] . '">' . $row[0] . '</option>';  
                        }
                ?>
        </select>
    </div>

    <div>
        <label for="facility">Facility:</label>
        <select name="facility" id="facilityTypeInfo">
                <?php 
                    $sqlFetch = 'SELECT facility_ID FROM facility group by facilityType order by facilityType';
                    foreach (DAOConstants::$pdo->query($sqlFetch) as $row) {
                            echo '<option value="'. $row[0] . '">' . $row[0] . '</option>';  
                        }
                ?>
        </select>
    </div>

    <div>
        <label for="startDate">Start Date:</label><input name="startDate" type="date"  class="weird-margin-error" required>
    </div>

    <div>
        <label for="endDate">End Date:</label><input name="endDate" type="date" class="weird-margin-error" >
    </div>

    <button class="indexB" ><a href="3.php">Back</a></button>
    <input type="submit" name="Create">


</form>

<?php 
    function callQuery(){
        if(empty($_POST['address']) === FALSE || empty($_POST['ssn']) === FALSE || empty($_POST['city']) === FALSE || empty($_POST['firstName']) === FALSE || empty($_POST['lastName']) === FALSE || empty($_POST['dateOfBirth']) === FALSE 
        ||  empty($_POST['postalCode']) === FALSE  ||  empty($_POST['country']) === FALSE || empty($_POST['phoneNumber']) === FALSE || empty($_POST['startDate']) === FALSE 
        ||  empty($_POST['citizenship']) === FALSE  ||  empty($_POST['email']) === FALSE || empty($_POST['facility']) === FALSE){
            try{
                $sql = null;
                if(empty($_POST['endDate'])){
                    $sql = "INSERT INTO employee (SSN, company_ID, firstName, lastName, dateOfBirth, citizenship, address, 
                    city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, position)
                    VALUES ('" . $_POST['SSN'] . "','" . $_POST['company_ID'] . "', '" . $_POST['firstName'] . "', '" . $_POST['lastName'] . "', '" . $_POST['dateOfBirth'] . "', '" . $_POST['citizenship'] . "', 
                    '" . $_POST['address'] . "', '" . $_POST['city'] . "', '" . $_POST['province'] . "',
                    '" . $_POST['postalCode'] . "', '" . $_POST['country'] . "', '" . $_POST['phoneNumber'] . "',
                    '" . $_POST['email'] . "', '" . $_POST['salary'] . "', '" . $_POST['facility'] . "',
                    '" . $_POST['startDate'] . "', " . $_POST['position'] . ")";
                }else{
                    $sql = "INSERT INTO employee (SSN, company_ID, firstName, lastName, dateOfBirth, citizenship, address, 
                    city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate, position)
                    VALUES ('" . $_POST['SSN'] . "','" . $_POST['company_ID'] . "', '" . $_POST['firstName'] . "',
                    '" . $_POST['lastName'] . "', '" . $_POST['dateOfBirth'] . "', '" . $_POST['citizenship'] . "', 
                    '" . $_POST['address'] . "', '" . $_POST['city'] . "', '" . $_POST['province'] . "',
                    '" . $_POST['postalCode'] . "', '" . $_POST['country'] . "', '" . $_POST['phoneNumber'] . "',
                    '" . $_POST['email'] . "', '" . $_POST['salary'] . "', '" . $_POST['facility'] . "', 
                    '" . $_POST['startDate'] . "', '" . $_POST['endDate'] . "', " . $_POST['position'] . ")";
                }
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

if (isset($_POST['Create'])){
    CallQuery();
  }
    echo '<div class="extra-space-large"></div>';
    echo ConstantValue::footer;
?>


