<?php
$db=mysqli_connect('localhost','root','','flutter');

if (!$db) {
	echo "Database connection failed";
}

$name=$_POST['name'];
$emailid=$_POST['emailid'];
$mobilenumber=$_POST['mobilenumber'];
$address=$_POST['address'];
$password=md5($_POST['password']);


$sql="SELECT * FROM login WHERE name='".$name."' AND emailid='".$emailid."' AND mobilenumber='".$mobilenumber."' AND address='".$address."' AND password='".$password."'";

$result=mysqli_query($db,$sql);
$count=mysqli_num_rows($result);

if ($count==1) {
	echo  json_encode("Error");
}
else
{
	//$otp    = mt_rand(1111, 9999);
	$insert="INSERT INTO login(name,emailid,mobilenumber,address,password)VALUES('".$name."','".$emailid."','".$mobilenumber."','".$address."','".$password."')";
	$query=mysqli_query($db,$insert);
	if ($query) {
		echo json_encode("Success");
		//sendSMS($mobilenumber, $otp);
	}
}

function sendSMS($mobilenumber, $otp) {
      // Account details
    //require $_SERVER['DOCUMENT_ROOT'].'/sms/vendor/autoload.php';


//  $MessageBird = new \MessageBird\Client('lg5FHnebH1PvpWiqR1KSRdgBp');
  //$Message = new \MessageBird\Objects\Message();
  //$Message->originator = 'MessageBird';
  //$Message->recipients = array("+9197020626);
 // $Message->body='The otp number is:'.$rand_no;

 //print_r(json_encode($MessageBird->messages->create($Message)));
   }

?>