<?php
function autoloaderPhp($class){
    require("./" . $class . ".php");
  }
  spl_autoload_register("autoloaderPhp");
  DAOConstants::$pdo = new PDO("mysql:host=" . DAOConstants::host
    . "; port=3306; dbname=" . DAOConstants::dbname,
  DAOConstants::user, DAOConstants::password);
  DAOConstants::$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 

  
  ConstantValue::createHeader("Question 19");
  echo '<div class="main-center">';
  echo '<ul>';

  
  function CallQuery(){
    try{
     
      $sql = "select facility.facilityName, facility.address, facility.city, facility.country, team.teamName, project.projectName, 
      project.startDate, project.endDate, COUNT(researchAssignment.researcher_SSN) as \"Number of Researchers\", sum(researchAssignment.totalHours) as \"Total Hours\"
      from  facility 
      join team on facility.company_ID = team.company_ID
      join project on team.team_ID = project.team_ID
      join researchAssignment on project.project_ID = researchAssignment.project_ID
      WHERE facility.country = \"USA\" 
      group by  project.project_ID";
  
      foreach (DAOConstants::$pdo->query($sql) as $row) {
        echo '<li><p> Research Facility Name: ' .$row[0].' <br> Facility Address: '. $row[1].' <br> Facility City: '. $row[2].' <br> Facility Country: '. $row[3].' <br> Team Name: '. $row[4]. ' <br> Project Name: '. $row[5].' <br> Start Date: '. $row[6].' <br> End Date: '. $row[7].' <br> Total Number of Researchers assigned to the Project: '. $row[8].' <br> Total Number of hours assigned to the Project: '. $row[9].'</p></li>' ;  
      }
      echo "</ul>";

    } catch(PDOException $e){
        echo "</ul>";
        echo $e->getMessage();
        echo ConstantValue::footer;
        exit;
    }
  }



  CallQuery();
  echo ConstantValue::footer;
?>