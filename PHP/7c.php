


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


<h2>Create Client Record</h2>

<form method="post">
    <div class="form-select">
        <div>
            <label for="companyName">Company Name: </label><input  class="weird-margin-error" name="companyName"  type="text" required>
        </div>

        <div>
            <label for="contactName">Contact Name: </label><input  class="weird-margin-error" name="contactName"  type="text" required>
        </div>

        <div>
            <label for="address">Address: </label><input  class="weird-margin-error" name="address"  type="text" required>
        </div>

        <div>
            <label for="city">City: </label><input  class="weird-margin-error" name="city" type="text"  type="text" required>
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
            <label for="postalCode">Postal Code: </label><input  class="weird-margin-error"  name="postalCode"  type="text" required>
        </div>

        <div>
            <label for="country">Country: </label><input  class="weird-margin-error" name="country"  type="text" required>
        </div>

        <div>
            <label for="phoneNumber">Phone Number: </label><input n class="weird-margin-error" ame="phoneNumber"  type="text" required>
        </div>

        <div>
            <label for="email">email: </label><input  class="weird-margin-error" name="email"  type="text" required>
        </div>
    </div>   
   
    <button class="indexB"><a href="7.php">Back</a></button>
    <input type="submit" name="submit">
</form>

<?php 
    function callQuery(){
        if(empty($_POST['client_ID']) === FALSE  || empty($_POST['companyName']) === FALSE || empty($_POST[' contactName ']) === FALSE  || empty($_POST['address']) === FALSE || empty($_POST['city']) === FALSE  ||  empty($_POST['province']) === FALSE     
        ||  empty($_POST['postalCode']) === FALSE    ||    empty($_POST['country']) === FALSE  || empty($_POST['phoneNumber']) === FALSE || empty($_POST['email']) === FALSE  ){
            try{
                $sql = "INSERT INTO  client (companyName, contactName, address, city, province, postalCode, country, phoneNumber, email) 
                        VALUES ('" . $_POST['companyName'] . "', '" . $_POST['contactName'] . "',
                                '" . $_POST['address'] . "', '" . $_POST['city'] . "', '" . $_POST['province'] . "', 
                                '" . $_POST['postalCode'] . "', '" . $_POST['country'] . "', '" . $_POST['phoneNumber'] ."', '" . $_POST['email'] . "');";
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