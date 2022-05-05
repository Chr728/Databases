
<?php
    function autoloaderPhp($class){
    require("./" . $class . ".php");
  }
    spl_autoload_register("autoloaderPhp");
    DAOConstants::$pdo = new PDO("mysql:host=" . DAOConstants::host
    . "; port=3306; dbname=" . DAOConstants::dbname,
    DAOConstants::user, DAOConstants::password);
    DAOConstants::$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
    $sql = 'SELECT * FROM team where  team_ID = ' . $_POST['team_ID'];
    $query = DAOConstants::$pdo->query($sql)->fetch();
  
    ConstantValue::createHeader("Question 4 Update");
    echo '<div class="main-center">';

?>

<form action="" method="post">
    <div class="form-select">
        
        <div>
            <label for=" team_ID">Team ID: </label>
            <input name=" team_ID" type="number" value="<?php echo $_POST['team_ID'] ?>" readonly>
        </div>
        <div>
            <label for="teamName">New Team Name: </label>
            <input name="teamName" type="text" value="<?php
                global $query;
                echo $query['teamName'];
             ?>" required>
        </div>
        <div>
            <label for="lead_SSN">SSN of leader: </label>
           
            <input name="lead_SSN"  type="text" value="<?php
                global $query;
                echo $query['lead_SSN'];
             ?>" required>
        </div>
            <button class="indexB"><a href="4v.php">Back</a></button>
            <input type="submit" name="submit">
    </div>
</form>

<?php 
    function callQuery(){
        if(empty($_POST['teamName']) === false || empty($_POST['lead_SSN']) === false){
            try{
                $sql = 'update team set teamName = "' . $_POST['teamName'] .  '" ,lead_SSN = "' . $_POST['lead_SSN'] .  '" WHERE team_ID = ' . $_POST['team_ID'];
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
