
<?php
function autoloaderPhp($class){
    require("./" . $class . ".php");
  }
  spl_autoload_register("autoloaderPhp");
  DAOConstants::$pdo = new PDO("mysql:host=" . DAOConstants::host
  . "; port=3306; dbname=" . DAOConstants::dbname,
  DAOConstants::user, DAOConstants::password);
  DAOConstants::$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
  
  
  ConstantValue::createHeader("Question 6 View");
  echo '<div class="main-center">';
?>

<form action="6e.php" method="post" id="post">
    <div class="form-select">
        <label for="product_ID"> Product Name: </label>
        <select name="UPC" id="productInfo">
    <?php 
        $sqlFetch = 'SELECT name,UPC FROM product order by  product_ID';
        foreach (DAOConstants::$pdo->query($sqlFetch) as $row) {
                echo '<option value='. $row[1] . '>' . $row[0] . '</option>';  
            }
    ?>
        </select>
    </div>
    <button class="indexB"><a href="6.php">Back</a></button>
    <input type="submit" name="Update/View" value="Update/View"/>
    <input type="submit" name="delete" value="Delete" formaction=""/>
</form>

    
<?php 
    function deleteItem(){
        try{
            $sql = 'delete from product where UPC = ' . $_POST['UPC'];
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











