<?php
// initialize connection and database name
// $username = "jpka";
// $password = "0uroboroS";
$host = "localhost";

BaseMongoRecord::$connection = new Mongo("mongodb://{$host}");
BaseMongoRecord::$database = "todo";