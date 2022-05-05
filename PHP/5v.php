
<?php
function autoloaderPhp($class){
    require("./" . $class . ".php");
  }
  spl_autoload_register("autoloaderPhp");
  DAOConstants::$pdo = new PDO("mysql:host=" . DAOConstants::host
  . "; port=3306; dbname=" . DAOConstants::dbname,
  DAOConstants::user, DAOConstants::password);
  DAOConstants::$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);


  ConstantValue::createHeader("Question 5 View");
  echo '<div class="main-center">';
?>

<form action="5e.php" method="post" id="post">
    <div class="form-select">
        <label for="companyName"> Project: </label>
        <select name="project_ID" id="projectInfo">
    <?php
        $sqlFetch = 'SELECT projectName, project_ID FROM project order by projectName';
        foreach (DAOConstants::$pdo->query($sqlFetch) as $row) {
                echo '<option value='. $row[1] . '>' . $row[0] . '</option>';
            }
    ?>
        </select>
    </div>
    <button class="indexB"><a href="5.php">Back</a></button>
    <input type="submit" name="update" value="Update/View"/>
    <input type="submit" name="delete" value="Delete" formaction=""/>
</form>

<?php
    function deleteItem(){
        try{
            $sql = 'delete from project where project_ID = ' . $_POST['project_ID'];
            DAOConstants::$pdo->query($sql);
            echo '<p class="success">Record deleted successfully</p>';
        } catch(PDOException $e){
            echo '<div class="extra-space-large"></div>';
            Helper::printError($e);
            exit;
        }
    }

    if(array_key_exists('delete', $_POST))
        deleteItem();

    echo '<div class="extra-space-large"></div>';
    echo ConstantValue::footer;
?>
