<?php

require("vendor/autoload.php");
require("models/User.php");
//require("config.php");

$r = new Respect\Rest\Router("/dev/todos/php/api");

$r->post("/login")->authBasic("", function($username, $password) {
  //$user = new User(array("username" => $data->username, "password" => $data->password));
  return $username === "jpka" && $password === "0uroboroS";
});