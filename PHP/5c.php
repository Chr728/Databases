
<?php
function autoloaderPhp($class){
    require("./" . $class . ".php");
  }
  spl_autoload_register("autoloaderPhp");
  DAOConstants::$pdo = new PDO("mysql:host=" . DAOConstants::host
  . "; port=3306; dbname=" . DAOConstants::dbname,
  DAOConstants::user, DAOConstants::password);
  DAOConstants::$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);


  ConstantValue::createHeader("Question 5 Create");
  echo '<div class="main-center">';
?>

<h2>Create Project Record</h2>

<form method="post">

    <div>
        <label for="projectName">Project Name: </label><input name="projectName" class="weird-margin-error" type="text" required>
    </div>

    <div>
        <label for="teamID">Team:</label>
        <select name="teamID" id="teamInfo">
            <?php 
                $sqlFetch = 'SELECT teamName, team_ID FROM team order by teamName';
                foreach (DAOConstants::$pdo->query($sqlFetch) as $row) {
                            echo '<option value="'. $row[1] . '">' . $row[0] . '</option>';  
                    }
            ?>
        </select>
    </div>

    <div>
        <label for="startDate">Start Date: </label><input  class="weird-margin-error" name="startDate" type="date" required>
    </div>

    <div>
        <label for="endDate">End Date: </label><input  class="weird-margin-error" name="endDate" type="date">
    </div>

    <button class="indexB" ><a href="5.php">Back</a></button>
    <input type="submit" name="submit">

</form>

<?php
    function callQuery(){
        if((empty($_POST['projectName']) === FALSE) || (empty($_POST['teamID']) === FALSE) || (empty($_POST['startDate']) === FALSE)){
            try{
                $sql = null;
                if (empty($_POST['endDate']) === false)
                    $sql = 'insert into project(projectName, team_ID, startDate, endDate) values ("'. $_POST['projectName'] . '", '. $_POST['teamID'] . ', "'. $_POST['startDate'] . '", "'. $_POST['endDate'] . '")';
                else
                    $sql = 'insert into project(projectName, team_ID, startDate) values ("'. $_POST['projectName'] . '", "'. $_POST['teamID'] . '", "'. $_POST['startDate'] . '")';
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
