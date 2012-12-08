<?php

class MongoModel extends BaseMongoRecord {
  public function validateString($str) {
    if (is_string($str)) {
      $str = trim($str);
      if (!empty($str))
        return true;
    }
    return false;
  }

  public function update($params) {
    foreach ($params as $field => $value) {
      if (property_exists($this, $field))
        $this->$field = $value;
      else
        return false;
    }
    return $this->save();
  }

  protected function isValid() {
    $className = get_called_class();
    $attrNames = $this->getAttributeNames();

    foreach (get_class_methods($className) as $method) {
        if (substr($method, 0, 9) == 'validates')
        {
            $attrName = substr($method, 9);
            $attrName{0} = strtolower($attrName{0});
            if (in_array($attrName, $attrNames)) {
                call_user_func(array($className, $method), $this->$attrName);
            }
            else {
                throw new Exception(sprintf("Cannot run the validator %s!  That attribute '%s' does not exist.", $method, $attrName));
            }
        }
    }

    return true;
  }

  public function expose() {
    return $this->getAttributes();
  }

  public static function findAllExposed($p, $s) {
    $found = self::findAll($p, $s);
    foreach ($found as $key => $value) {
      $found[$key] = $value->expose();
    }
    return $found;
  }
}