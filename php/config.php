<?php

$apiRoute = "/api";
BaseMongoRecord::$connection = new Mongo("mongodb://jpka:0uroboroS@ds045137.mongolab.com:45137/todo");
BaseMongoRecord::$database = "todo";