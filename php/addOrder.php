<?php
header("content-type:text/javascript;charset=utf-8");
error_reporting(0);
error_reporting(E_ERROR | E_PARSE);
$link = mysqli_connect('localhost', 'root', '', "BCCShop");

if (!$link) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    
    exit;
}

if (!$link->set_charset("utf8")) {
    printf("Error loading character set utf8: %s\n", $link->error);
    exit();
	}

if (isset($_GET)) {
	if ($_GET['isAdd'] == 'true') {
				
		$OrderDateTime = $_GET['OrderDateTime'];
		$idShop = $_GET['idShop'];
		$NameShop = $_GET['NameShop'];
		$Distance = $_GET['Distance'];
		$Transport = $_GET['Transport'];
		$idProduct = $_GET['idProduct'];
		$NameProduct = $_GET['NameProduct'];
		$Price = $_GET['Price'];
		$Amount = $_GET['Amount'];
		$Sum = $_GET['Sum'];
		$idRider = $_GET['idRider'];
		$Status= $_GET['Status'];

							
		$sql = "INSERT INTO `orderTABLE`(`id`, `OrderDateTime`, `idShop`, `NameShop`, `Distance`, `Transport`, `idProduct`, `NameProduct`, `Price`, `Amount`, `Sum`, `idRider`, `Status`) VALUES (Null,'$OrderDateTime','$idShop','$NameShop','$Distance','$Transport','$idProduct','$NameProduct','$Price','$Amount','$Sum','$idRider','$Status')";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Welcome Master UNG";
   
}
	mysqli_close($link);
?>