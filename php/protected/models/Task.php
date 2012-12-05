<?php

class Task extends EMongoDocument {
  public $description;
  public $status = false;

  /**
   * This method have to be defined in every Model
   * @return string MongoDB collection name, witch will be used to store documents of this model
   */
  public function getCollectionName() {
    return 'tasks';
  }
 
  // We can define rules for fields, just like in normal CModel/CActiveRecord classes
  public function rules() {
    return array(
      array('description', 'required'),
      array('status', 'boolean')
    );
  }
 
  // the same with attribute names
  public function attributeNames() {
    return array(
      'description' => 'Description',
      'status' => 'Status'
    );
  }
 
  /**
   * This method have to be defined in every model, like with normal CActiveRecord
   */
  public static function model($className=__CLASS__) {
    return parent::model($classname);
  }
}