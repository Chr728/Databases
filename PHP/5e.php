
<?php
    function autoloaderPhp($class){
    require("./" . $class . ".php");
  }
    spl_autoload_register("autoloaderPhp");
    DAOConstants::$pdo = new PDO("mysql:host=" . DAOConstants::host
    . "; port=3306; dbname=" . DAOConstants::dbname,
    DAOConstants::user, DAOConstants::password);
    DAOConstants::$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $sql = 'SELECT projectName, startDate, endDate FROM project where project_ID = ' . $_POST['project_ID'];
    $query = DAOConstants::$pdo->query($sql)->fetch();

    ConstantValue::createHeader("Question 5 Update");
    echo '<div class="main-center">';

?>

<form action="" method="post">
    <div class="form-select">
        <div>
            <label for="project_ID">Project ID: </label>
            <input name="project_ID" type="number" value="<?php echo $_POST['project_ID'] ?>" readonly>
        </div>
        <div>
            <label for="projectName">New Project Name: </label>
            <input name="projectName"  type="text" value="<?php
                global $query;
                echo $query['projectName'];
             ?>" required>
        </div>
        <div>
            <label for="startDate">New Start Date: </label>
            <input name="startDate" type="date" value="<?php
                global $query;
                echo $query['startDate'];
             ?>" required>
        </div>
        <div>
            <label for="endDate">New End Date: </label>
            <input name="endDate"  type="date" value="<?php
                global $query;
                echo $query['endDate'];
             ?>">
        </div>
            <button class="indexB"><a href="5v.php">Back</a></button>
            <input type="submit" name="submit">
    </div>
</form>

<?php
    function callQuery(){
        try{
            $sql = null;
            if(empty($_POST['endDate']) === false){
                $sql = 'update project set projectName = "' . $_POST['projectName'] . '", startDate = "' . $_POST['startDate'] . '", endDate = "' . $_POST['endDate'] . '" WHERE project_ID = ' . $_POST['project_ID'];
            }
            else{
                $sql = 'update project set projectName = "' . $_POST['projectName'] . '", startDate = "' . $_POST['startDate'] . '", endDate = null WHERE project_ID = ' . $_POST['project_ID'];
            }
            DAOConstants::$pdo->query($sql);
            echo '<p class="success">Record updated successfully</p>';
        } catch(PDOException $e){
            echo '<div class="extra-space-large"></div>';
            Helper::printError($e);
            exit;
        }
    }


if (isset($_POST['submit'])){
    CallQuery();
  }


    echo '<div class="extra-space-large"></div>';
    echo ConstantValue::footer;
?>
