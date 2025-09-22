<?php

use think\Session;
use think\Request;
use think\Controller;

function passPlugin() {

    if(session::has('pass_plugin')) return true;

    if(!encodePassPlugin('pass_plugin')){



        $plugin_path = ROOT_PATH . "content/pass/";
        $info = include_once "{$plugin_path}setting.php";



        echo <<<html


<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="description" content="Responsive Admin Dashboard Template">
		<meta name="keywords" content="admin,dashboard">
		<meta name="author" content="stacks"><!-- The above 6 meta tags *must* come first in the head;any other head content must come *after* these tags -->
		<!-- Title -->
		<title>{$info['title']}</title><!-- Styles -->
		<link href="/template/pass/css/css.css" rel="stylesheet">
		<link href="/template/pass/css/bootstrap.min.css" rel="stylesheet">
		<link href="/template/pass/css/all.min.css" rel="stylesheet">
		<link href="/template/pass/css/perfect-scrollbar.css" rel="stylesheet"><!-- Theme Styles -->
		<link href="/template/pass/css/main.min.css" rel="stylesheet">
		<link href="/template/pass/css/custom.css" rel="stylesheet"><!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
		<!-- WARNING:Respond.js doesn't work if you view the page via file:// -->
		<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
	</head>
	<body class="login-page">
		
		<div class="container">
			<div class="row justify-content-md-center">
				<div class="col-md-12 col-lg-4">
					<div class="card login-box-container">
						<div class="card-body">
							<div class="authent-logo">
								<img src="{$info['image']}" width="60" alt="" style="border-radius: 30px;">
							</div>
							<div class="authent-text">
								<p>{$info['one_text']}</p>
								<p>{$info['two_text']}</p>
							</div>
							<form>
								<div class="mb-3">
									<div class="form-floating">
										<input type="password" class="form-control" id="floatingPassword" name="pass_plugin" placeholder="{$info['placeholder']}">
										<label for="floatingPassword">{$info['placeholder']}</label>
									</div>
								</div>
								<div class="d-grid">
									<button type="submit" class="btn btn-info m-b-xs">{$info['button']}</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>
html;

        die;

    }
}

addAction('init', 'passPlugin');


function verifyPassPlugin(){
    if($pass = encodePassPlugin('pass_plugin')){
        $plugin_path = ROOT_PATH . "content/pass/";
        $info = include_once "{$plugin_path}setting.php";
        if($pass != $info['pwd']){
            echo "<script>alert('密码错误 ');window.history.back(-1);</script>";die;
        }else{
            session::set('pass_plugin', true);
            echo "<script>window.history.back(-1);</script>";die;
        }
    }
}
addAction('init', 'verifyPassPlugin');


function encodePassPlugin($key) {
    if(isset($_GET[$key])) {
        $value = trim($_GET[$key]);
        $value = stripslashes($value);
        $value = htmlspecialchars($value);
        return $value;
    }
    return null;
}



?>