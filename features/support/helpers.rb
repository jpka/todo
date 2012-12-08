def logout
  page.driver.remove_cookie("username")
  page.driver.remove_cookie("password")
end

def db
  MongoClient.new("localhost", 27017).db("todo")
end

def users_coll
  db.collection('users')
end

def tasks_coll
  db.collection('tasks')
end

def reset_db
  users_coll.remove
  tasks_coll.remove
end

def add_user(username, password)
  users_coll.insert({"username" => username, "password" => password})
end

def add_task(username, desc, priority)
  @hash ||= {}
    
  if @hash.has_key?(username)
    @hash[username] = @hash[username] + 1
  else
    @hash[username] = 1
  end
    
  tasks_coll.insert({"user" => username, "description" => desc, "done" => false, "id" => @hash[username], "priority" => priority})
end