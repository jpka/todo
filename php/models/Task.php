<?php

class Task extends MongoModel {
  protected static $collectionName = "tasks";
  protected $user;
  protected $description;
  protected $dueDate;
  protected $done = false;
  protected $id;
  protected $priority = 0;

  public function validatesDueDate($dueDate) {
    if (!empty($dueDate)) {
      try {
        $this->dueDate = new MongoDate(strtotime($dueDate));
      } catch (Exception $e) {
        throw new Exception("Invalid date");
      }
    }

    return true;
  }

  public function validatesDescription($description) {
    if (!$this->validateString($description)) {
      throw new Exception("Description is required");
    }

    return true;
  }

  public function validatesPriority($priority) {
    try {
      $this->priority = intval($priority);
    } catch (Exception $e) {
      throw new Exception("Priority must be a number");
    }
    
    if ($priority < 0 || $priority > 10)
      throw new Exception("Priority must be between 1 and 10");

    return true;
  }

  public function validatesUser($user) {    
    if (!$this->validateString($user))
      throw new Exception("User is required");
    else if (is_null(User::findOne(array("username" => $this->user))))
      throw new Exception("User does not exist");

    return true;
  }

  public function beforeSave() {
    if (is_null($this->id)) {
      $count = count(Task::findAll(array("user" => $this->user)));
      $this->id = $count + 1;
    }
  }

  public function expose() {
    $attrs = $this->getAttributes();
    if (!is_null($attrs["dueDate"]))
      $attrs["dueDate"] = date("Y-m-d", $attrs["dueDate"]->sec);
    return $attrs;
  }

  // public function __get($what) {
  //   return "a";
  //   if ($what === "dueDate")
  //     return $this->dueDate = date("Y-M-d h:i:s", $this->dueDate->sec);
  //   else
  //     return parent::__get($what);
  // }
}
