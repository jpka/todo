<?php

require("vendor/autoload.php");
require("config.php");
require("models/Model.php");
require("models/User.php");
require("models/Task.php");

$r = new Respect\Rest\Router($apiRoute);

$r->always("Accept", array("application/json" => "json_encode"));

class UnauthorizedException extends Exception {}

$r->exceptionRoute("UnauthorizedException", function (UnauthorizedException $e) {
  header(" ", true, 401);
  $message = $e->getMessage();
  return array("error" => empty($message) ? "Unauthorized" : $message);
});

$r->exceptionRoute("Exception", function (Exception $e) {
  header(" ", true, 403);
  $message = $e->getMessage();
  if (!empty($message))
    return array("error" => $message);
  else
    return false;
});

function authSuccesful($username, $password) {
  setcookie("username", $username, time() + 60*60*24*30, $apiRoute . "/");
  setcookie("password", $password, time() + 60*60*24*30, $apiRoute . "/");
  return array("username" => $username, "tasks" => Task::findAllExposed(array("user" => $username)));
}

function authenticate($user) {
  $username = isset($_COOKIE["username"]) ? $_COOKIE["username"] : $_GET["username"];
  if (isset($user) && $user !== $username) {
    throw new UnauthorizedException();
    return false;
  }
  $password = isset($_COOKIE["password"]) ? $_COOKIE["password"] : $_GET["password"];
  $user = new User(array("username" => $username, "password" => $password));

  try {
    $user->authenticate();
    return true;
  } catch (Exception $e) {
    throw new UnauthorizedException($e->getMessage());
    return false;
  }
}

function postOrPutData() {
  $data = array();
  foreach ((empty($_POST) ? json_decode(file_get_contents("php://input"), true) : $_POST) as $field => $value) {
    if (!empty($value))
      $data[$field] = $value;
  }
  return $data;
}

$r->get("/login", function() {
  $username = isset($_COOKIE["username"]) ? $_COOKIE["username"] : $_GET["username"];
  $password = isset($_COOKIE["password"]) ? $_COOKIE["password"] : $_GET["password"];
  return authSuccesful($username, $password);
})->by("authenticate");

$r->get("/logout", function() {
  setcookie("username", "", time() + 60*60*24*30, $apiRoute . "/");
  setcookie("password", "", time() + 60*60*24*30, $apiRoute . "/");
  return true;
});

$r->post("/register", function() {
  $user = new User(array("username" => $_POST["username"], "password" => $_POST["password"]));
  $user->save();
  return authSuccesful($user->username, $user->password);
});

$r->get("/*/tasks", function($user) {
  $sortOpts = null;
  if (isset($_GET["sortedBy"]))
    $sortOpts = array("sort" => array($_GET["sortedBy"] => isset($_GET["desc"]) ? -1 : 1));
  return Task::findAllExposed(array("user" => $user), $sortOpts);
})->by("authenticate");

$r->post("/*/tasks", function($user) {
  $task = new Task(postOrPutData());
  $task->user = $user;
  $task->save();
  return $task->expose();
})->by("authenticate");

$r->get("/*/tasks/*", function($user, $id) {
  return Task::findOne(array("user" => $user, "id" => intval($id)))->expose();
})->by("authenticate");

$r->put("/*/tasks/*", function($user, $id) {
  $task = Task::findOne(array("user" => $user, "id" => intval($id)));
  $task->update(postOrPutData());
  return $task->expose();
})->by("authenticate");

$r->delete("/*/tasks/*", function($user, $id) {
  $task = Task::findOne(array("user" => $user, "id" => intval($id)));
  $task->destroy();
  return true;
})->by("authenticate");