
<?php
function autoloaderPhp($class){
    require("./" . $class . ".php");
  }
  spl_autoload_register("autoloaderPhp");
  ConstantValue::createHeader("Question 5");
?>

<div class="main-center">
    <h2>Project Menu</h2>

    <a href="5c.php"><button class="indexB">Create</button></a>
    <a href="5v.php"><button class="indexB">Search</button></a>
    <div class="extra-space-large"></div>
</div>

<?php
    echo ConstantValue::footer;
?>
