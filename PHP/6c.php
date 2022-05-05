
<?php
function autoloaderPhp($class){
    require("./" . $class . ".php");
  }
  spl_autoload_register("autoloaderPhp");
  DAOConstants::$pdo = new PDO("mysql:host=" . DAOConstants::host
    . "; port=3306; dbname=" . DAOConstants::dbname,
  DAOConstants::user, DAOConstants::password);
  DAOConstants::$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
  
  ConstantValue::createHeader("Question 6 Create");
  echo '<div class="main-center">';
?>


<h2>Create Product Record</h2>

<form method="post">
    <div class="form-select">
        <div>
            <label for="product_ID">Product ID: </label><input name="product_ID" type="text"  class="weird-margin-error" required>
        </div>

        <div>
            <label for="name">Name: </label><input name="name"  type="text" class="weird-margin-error"  required>
        </div>

        <div>
            <label for="description">Description: </label><input name="description" class="weird-margin-error" type="text" required>
        </div>

        <div>
            <label for="volume">Volume: </label><input name="volume"  type="text"  class="weird-margin-error" required>
        </div>

        <div>
            <label for="weight">Weight: </label><input name="weight"  type="text"  class="weird-margin-error" required>
        </div>

        <div>
            <label for="price">Price: </label><input name="price"  type="text"  class="weird-margin-error" required>
        </div>
        <div>
            <label for="status">Status:</label>
            <select name="status" id="statusInfo">
                <option value="Available">Available</option>
                <option value="Unavailable">Unvailable</option>
            </select>
        <div>
    </div>    

    </div>
    <button class="indexB"><a href="6.php">Back</a></button>
    <input type="submit" name="submit">
</form>

<?php 
    function callQuery(){
        if(empty($_POST['product_ID']) === FALSE || empty($_POST['name']) === FALSE  || empty($_POST['description']) === FALSE
         || empty($_POST['volume']) === FALSE  ||  empty($_POST['weight']) === FALSE     
        ||empty($_POST['price']) === FALSE){
            try{
                $sql = "INSERT INTO product(product_ID, name, description, volume, weight, price, status)
                        VALUES ('" . $_POST['product_ID'] . "', '" . $_POST['name'] . "', '" . $_POST['description'] . "',
                                '" . $_POST['volume'] . "', '" . $_POST['weight'] . "', '" . $_POST['price'] . "', 
                                '" . $_POST['status'] . "');";
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


