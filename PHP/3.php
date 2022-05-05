<?php
function autoloaderPhp($class){
    require("./" . $class . ".php");
}
spl_autoload_register("autoloaderPhp");
ConstantValue::createHeader("Question 3");
?>

<div class="main-center">
    <h2>Employee Menu</h2>

    <a href="3c.php"><button class="indexB">Create</button></a>
    <a href="3v.php"><button class="indexB">Display</button></a>
    <div class="extra-space-large"></div>
</div>

<?php
echo ConstantValue::footer;
?>
