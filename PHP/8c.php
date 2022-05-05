<?php
function autoloaderPhp($class){
    require("./" . $class . ".php");
  }
  spl_autoload_register("autoloaderPhp");
  DAOConstants::$pdo = new PDO("mysql:host=" . DAOConstants::host
  . "; port=3306; dbname=" . DAOConstants::dbname,
  DAOConstants::user, DAOConstants::password);
  DAOConstants::$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

  ConstantValue::createHeader("Question 8 Create");
  echo '<div class="main-center">';
?>


<h2>Create Contract Record</h2>

<form action="" method="post">
    <div class="form-select">
        <div>
            <label for="client_ID">Client:</label>
            <select name="client_ID" id="client_ID_Info">
                    <?php 
                        $sqlFetch = 'SELECT client_ID, companyName FROM client order by companyName';
                        foreach (DAOConstants::$pdo->query($sqlFetch) as $row) {
                                echo '<option value="'. $row[0] . '">' . $row[1] . '</option>';  
                            }
                    ?>
            </select>
        </div>

        <div>
            <label for="clientName">Client Name: </label><input name="clientName"  class="weird-margin-error" type="text" required>
        </div>

        <div>
            <label for="company_ID">Company:</label>
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
            <label for="SSN">Employee Contract: </label>
            <select name="SSN" id="SSN">
                <?php
                $sqlFetch2 = 'SELECT SSN, firstName, lastName, companyName FROM employee join pharmaCompany on employee.company_ID = pharmaCompany.company_ID order by SSN DESC';
                foreach (DAOConstants::$pdo->query($sqlFetch2) as $row) {
                    echo '<option value='. $row[0] . '>' . $row[1] . ' ' . $row[2] . ' (Company: ' . $row[3] . ')</option>';
                }
                ?>
            </select>
        </div>

        <div>
            <label for="position">Employee Position:</label>
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
            <label for="contractDate">Contract Date: </label><input name="contractDate"  class="weird-margin-error" type="date" required>
        </div>

        <div>
            <label for="deliveryDate">Delivery Date: </label><input name="deliveryDate"  class="weird-margin-error" type="date" required>
        </div>
    </div> 
    <button class="indexB" ><a href="8.php">Back</a></button>
    <input type="submit" name="submit">  
</form>



<?php
    function callQuery(){
        if((empty($_POST['clientID']) === FALSE)
        || (empty($_POST['clientName']) === FALSE)
        || (empty($_POST['companyID']) === FALSE)
        || (empty($_POST['SSN']) === FALSE)
        || (empty($_POST['position']) === FALSE)
        || (empty($_POST['contractDate']) === FALSE)
        || (empty($_POST['deliveryDate']) === FALSE)){
            try{
                $sql = 'insert into contract (client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values
                ("'. $_POST['client_ID'] . '", "'. $_POST['clientName'] . '", "'. $_POST['company_ID'] . '", "'. $_POST['SSN'] . '",
                 "'. $_POST['position'] . '", "'. $_POST['contractDate'] . '", "'. $_POST['deliveryDate'] . '")';
                $query = DAOConstants::$pdo->query($sql);
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
