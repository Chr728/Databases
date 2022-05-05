<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <Title>353 Project</Title>
  <link rel="stylesheet" href="stylesheet.css">
</head>
<body id ="root">
<header class ="header">
  <h1 id="header-title-left">coc353_4</h1>
  <h1 id="header-title-right" class="index-header-title-right">353 Main Project</h1>
</header>
  </head>
    <div class="main-center">
      <div class="center">
        <h1 id="main-title-center">Questions 1-20 for 353 Main Project</h1>
      </div>
    <h2>Queries: </h2>
    <ul id="links">
      <li><a href="1.php">Question 1 : Create, Delete, Edit, Display a Company</a></li>
      <li><a href="2.php">Question 2 : Create, Delete, Edit, Display a Facility</a></li>
      <li><a href="3.php">Question 3 : Create, Delete, Edit, Display an Employee</a></li>
      <li><a href="4.php">Question 4 : Create, Delete, Edit, Display a team</a></li>
      <li><a href="5.php">Question 5 : Create, Delete, Edit, Display a Project</a></li>
      <li><a href="6.php">Question 6 : Create, Delete, Edit, Display a Product</a></li>
      <li><a href="7.php">Question 7 : Create, Delete, Edit, Display a Client</a></li>
      <li><a href="8.php">Question 8 : Create, Delete, Edit, Display a Contract</a></li>
      <li><a href="9.php">Question 9 : Assign a new CEO for a company</a></li>
      <li><a href="10.php">Question 10 : Assign a Researcher to a project</a></li>
      <li><a href="11.php">Question 11 : Details of all companies</a></li>
      <li><a href="12.php">Question 12 : Details of companies that have at least one warehouse facility in everycountry that they have at least one contract with clients in that country</a></li>
      <li><a href="13.php">Question 13 : Details of companies that do not have any contracts signed with any client in the country where their head office is located</a></li>
      <li><a href="14.php">Question 14 : Details of all the contracts for Pfizer</a></li>
      <li><a href="15.php">Question 15 : Details of all the contracts that are signed by every client</a></li>
      <li><a href="16.php">Question 16 :  Details of all the researchers who worked as researchers for at least three different companies</a></li>
      <li><a href="17.php">Question 17 : Details of researchers who worked on all projects for Pfizer</a></li>
      <li><a href="18.php">Question 18 : Report of the total hours assigned to researchers throughout their career</a></li>
      <li><a href="19.php">Question 19 : Details of all the projects that are performed by Pfizer research centers that are located in the United States Of America</a></li>
      <li><a href="20.php">Question 20 : Yearly report of sales for each company from 2019 to 2022</a></li>
    </div>
</ul>
<?php
  function autoloaderPhp($class){
  require("./" . $class . ".php");
  }
  spl_autoload_register("autoloaderPhp");
  DAOConstants::$pdo = new PDO("mysql:host=" . DAOConstants::host . "; port=3306; dbname=" . DAOConstants::dbname, DAOConstants::user, DAOConstants::password);
  echo ConstantValue::coreFooter; 
?>