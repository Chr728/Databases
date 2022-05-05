<?php
function autoloaderPhp($class){
    require("./" . $class . ".php");
}
spl_autoload_register("autoloaderPhp");
DAOConstants::$pdo = new PDO("mysql:host=" . DAOConstants::host
    . "; port=3306; dbname=" . DAOConstants::dbname,
    DAOConstants::user, DAOConstants::password);
DAOConstants::$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

ConstantValue::createHeader("Question 3 View");
echo '<div class="main-center">';
?>

<form action="3e.php" method="post" id="post">
     <p> <strong> Please enusre that Company Name matches company listed in Employee Name field </strong> </p>
    <div class="form-select">
        <div>
            <label for="company_ID">Company Name: </label>
            <select name="company_ID" id="company_ID">
                <?php
                $sqlFetch1 = 'SELECT company_ID, companyName FROM pharmaCompany order by company_ID ';
                foreach (DAOConstants::$pdo->query($sqlFetch1) as $row) {
                    echo '<option value='. $row[0] . '>' . $row[1] . '</option>';

                }

                ?>
            </select>
        </div>
        <div>
            <label for="SSN">Employee Name: </label>
            <select name="SSN" id="SSN">
                <?php
                $sqlFetch2 = 'SELECT SSN, firstName, lastName, companyName FROM employee join pharmaCompany on employee.company_ID = pharmaCompany.company_ID 
                                where endDate IS null OR endDate > current_date() order by endDate ASC';
                foreach (DAOConstants::$pdo->query($sqlFetch2) as $row) {
                    echo '<option value='. $row[0] . '>' . $row[1] . ' ' . $row[2] . ' (Company: ' . $row[3] . ')</option>';
                }
                ?>
            </select>
        </div>
    </div>

    <button class="indexB"><a href="3.php">Back</a></button>
    <input type="submit" name="update" value="Update/View"/>
    <input type="submit" name="delete" value="Delete" formaction=""/>
</form>

<?php

function deleteItem(){
    $sql = 'select SSN from employee where company_ID = ' . $_POST['company_ID'] . ' and SSN = ' . $_POST['SSN'];
    $result = DAOConstants::$pdo->query($sql)->fetch();
    if ($result !== false){
        try{
            $sql = 'delete from employee where company_ID = ' . $_POST['company_ID'].' AND SSN = ' . $_POST['SSN'].' AND position = (select position from (select position from employee where SSN = ' . trim($_POST['SSN']) . ' order by endDate desc limit 1) as fname)';
            DAOConstants::$pdo->query($sql);
            echo '<p class="success">Record deleted successfully</p>';
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

if(array_key_exists('delete', $_POST))
    deleteItem();

echo '<div class="extra-space-large"></div>';
echo ConstantValue::footer;
?>









