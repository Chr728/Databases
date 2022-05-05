<?php
function autoloaderPhp($class){
    require("./" . $class . ".php");
  }
  spl_autoload_register("autoloaderPhp");
  
  ConstantValue::createHeader("Question 2");
?>

<div class="main-center">
    <h2>Facility Menu</h2>

    <a href="2c.php"><button class="indexB">Create</button></a>
    <a href="2v.php"><button class="indexB">Search</button></a>
    <div class="extra-space-large"></div>
</div>

<?php 
    echo ConstantValue::footer;
?>