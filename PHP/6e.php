
<?php
    function autoloaderPhp($class){
    require("./" . $class . ".php");
  }
    spl_autoload_register("autoloaderPhp");
    DAOConstants::$pdo = new PDO("mysql:host=" . DAOConstants::host
    . "; port=3306; dbname=" . DAOConstants::dbname,
    DAOConstants::user, DAOConstants::password);
    DAOConstants::$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
    $sql = 'SELECT * FROM product where  UPC= ' . $_POST['UPC'];
    $query = DAOConstants::$pdo->query($sql)->fetch();
  
    ConstantValue::createHeader("Question 6 Update");
    echo '<div class="main-center">';

?>

<form action="" method="post">
    <div class="form-select">
        
        <div>
            <label for="UPC">UPC </label>
            <input name="UPC" type="number" value="<?php echo $_POST['UPC'] ?>" readonly>
        </div>
        <div>
            <label for="product_ID">Product ID: </label>
            <input name="product_ID" type="text" value="<?php
                global $query;
                echo $query['product_ID'];
             ?>" readonly>
        </div>
        <div>
            <label for="name">New Name of product: </label>
           
            <input name="name"  type="text" value="<?php
                global $query;
                echo $query['name'];
             ?>" required>
        </div>
        <div>
            <label for="description">New description: </label>
            <input name="description"  type="text" value="<?php
                global $query;
                echo $query['description'];
             ?>" required>
        </div>
        <div>
            <label for="volume">New  volume: </label>
            <input name="volume"  type="text" value="<?php
                global $query;
                echo $query['volume'];
             ?>" required>
        </div>
        <div>
            <label for="weight">New weight: </label>
           <input name="weight"  type="text" value="<?php
                global $query;
                echo $query['weight'];
             ?>" required>
        </div>

        
        <div>
            <label for="price">New  price: </label>
            <input name="price"  type="text" value="<?php
                global $query;
                echo $query['price'];
             ?>" required>
        </div>
        <div>
            <label for="status">Status:</label>
            <select name="status" id="statusInfo">
                <option value="Available">Available</option>
                <option value="Unavailable">Unvailable</option>
            </select>
        </div>
        <div>
            <button class="indexB"><a href="6v.php">Back</a></button>
            <input type="submit"  type="text" name="submit">
        </div>
    </div>
</form>

<?php 
    function callQuery(){
        if(empty($_POST['name']) === false || empty($_POST['description']) === false || empty($_POST['volume']) === false || empty($_POST['weight']) === false 
         || empty($_POST['price']) === false || empty($_POST['status']) === false ){
            try{
                $sql = 'update product set name = "' . $_POST['name'] .  '" ,description= "' . $_POST['description'] .  
                '" ,volume= "' . $_POST['volume'] .  '" ,weight = "' . $_POST['weight'] .  '" ,price = "' . $_POST['price'] .  '" 
                ,status= "' . $_POST['status'] .  '"  
                             WHERE UPC = ' . $_POST['UPC'];
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
