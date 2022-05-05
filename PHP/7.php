<?php
function autoloaderPhp($class){
    require("./" . $class . ".php");
  }
  spl_autoload_register("autoloaderPhp");
  
  ConstantValue::createHeader("Question 7");
?>

<div class="main-center">
    <h2>Client Menu</h2>

    <a href="7c.php"><button class="indexB">Create</button></a>
    <a href="7v.php"><button class="indexB">Search</button></a>
    <div class="extra-space-large"></div>
</div>

<?php 
    echo ConstantValue::footer;
?>