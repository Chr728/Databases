<?php
function autoloaderPhp($class){
    require("./" . $class . ".php");
  }
  spl_autoload_register("autoloaderPhp");
  ConstantValue::createHeader("Question 1");
?>

<div class="main-center">
    <h2>Company Menu</h2>
    
    <a href="1c.php"><button class="indexB">Create</button></a>
    <a href="1v.php"><button class="indexB">Search</button></a>
    <div class="extra-space-large"></div>
</div>

<?php 
    echo ConstantValue::footer;
?>
