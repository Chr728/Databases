<?php

  class Helper {
    static function printError($value){
      echo '<div class="error">';
      if (strpos($value, "foreign key constraint") !== false){
        echo '<p>Impossible to modify that row as it is linked to active records. Please remove it from the other records before deleting</p>';
      }else if(strpos($value, "Duplicate entry") !== false){
        echo '<p>Query has failed due to this value already existing in the database</p>';
      } else{
        echo '<p> '. $value . '</p>';
      }
      echo ConstantValue::footer;
      exit;
    }

    static function verifyBooleans($booleanArray, $messageArray){
      if (count($booleanArray) != count($messageArray)){
        return false;
      }
      echo '<div class = "error"><p> Warning: An error has occured executing your Query: <br>';
      for($i = 0; $i < count($booleanArray); $i++){
        if(is_null($booleanArray[$i]) === false && $booleanArray[$i] === false){
          echo $messageArray[$i] . '<br>';
        }
      }
      echo '</p></div>';
      echo ConstantValue::footer;
    }

    static function verifyQuery($pdo, $sql, $symbol, $comparator){
      try{
        foreach ($pdo->query($sql) as $row) {
          if($symbol === "<"){
            return $row[0] < $comparator;
          }elseif($symbol === ">"){
            return $row[0] > $comparator;
          }
        }
        return false;
      } catch(PDOException $e){
        Helper::printError($e);
        return false;
      }
  }
}

?>
