<?php

class User extends BaseMongoRecord {
  protected static $collectionName = "users";
  protected $username;
  protected $password;

  public function validate($str) {
    if (is_string($str) && strlen($str) > 0)
      return true;
    else
      return false;
  }

  public function validatesUsername($name) {
    return validate($name);
  }

  public function validatesPassword($pass) {
    return validate($pass);
  }
}
