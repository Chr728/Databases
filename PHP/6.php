<?php
function autoloaderPhp($class){
    require("./" . $class . ".php");
  }
  spl_autoload_register("autoloaderPhp");
  
  ConstantValue::createHeader("Question 6");
?>

<div class="main-center">
    <h2>Product Menu</h2>

    <a href="6c.php"><button class="indexB">Create</button></a>
    <a href="6v.php"><button class="indexB">Search</button></a>
    <div class="extra-space-large"></div>
</div>

<?php 
    echo ConstantValue::footer;
?>