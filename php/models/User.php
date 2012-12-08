<?php

class User extends MongoModel {
  protected static $collectionName = "users";
  protected $username;
  protected $password;

  public function validatesUsername($name) {
    if (!$this->validateString($name))
      throw new Exception("Username is required");
    return true;
  }

  public function validatesPassword($pass) {
    if (!$this->validateString($pass))
      throw new Exception("Password is required");
    return true;
  }

  public function authenticate() {
    $this->validate();
    
    $user = User::findOne(array("username" => $this->username));
    if (is_null($user))
      throw new Exception("Invalid username");
    else if ($user->password !== $this->password)
      throw new Exception("Invalid password");
    
    return true;
  }

  public function beforeSave() {
    if (!is_null(User::findOne(array("username" => $this->username))))
      throw new Exception("Username is taken");
  }
}
