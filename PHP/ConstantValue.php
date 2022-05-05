<?php
    class ConstantValue{
        const footer = '<a href="index.php"><button class="indexB">Return to Index</button></a>' . ConstantValue::coreFooter ;

        const coreFooter = '</div>
        <footer>
        <h4 class="footer">Made by Daniel Rafail, Stephen LaPierre, Christina Darstbanian, Russell Abraira</h4>
        <h4 class="footer">Comp 353 - Winter Semester of 2022</h4>
        </footer>
        </body>
        </html>';

        static function createHeader($questionNumber){
          echo '<!DOCTYPE html>
          <html lang="en">
          <head>
            <meta charset="UTF-8">
            <Title>353 Project</Title>
            <link rel="stylesheet" href="stylesheet.css">
          </head>
          <body id ="root">
          <header class ="header">
            <h1 id="header-title-left">' . $questionNumber .'</a></h1>
              <h1 id="header-title-right" class="questions-header-title-right"><a href = "index.php">353 Main Project</a></h1>
          </header>';
        }
    }
?>