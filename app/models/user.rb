class User < ActiveRecord::Base
  attr_accessible :count, :password, :username
  
  validates :password,  :length => { :maximum => 128 }
  validates :username,  :length => { :maximum => 128 }
  
  SUCCESS               =   1  # : a success
  ERR_BAD_CREDENTIALS   =  -1  # : (for login only) cannot find the user/password pair in the database
  ERR_USER_EXISTS       =  -2  # : (for add only) trying to add a user that already exists
  ERR_BAD_USERNAME      =  -3  # : (for add only) invalid user name (only empty string is invalid for now)
  ERR_BAD_PASSWORD      =  -4
  
  def self.login(user, password)
    u = User.find_by_username_and_password(user, password)
    if u.nil?
      return ERR_BAD_CREDENTIALS
    else
      u.count += 1
      u.save
      return u.count
    end 
  end
  
  def self.add(user, password)
    if user.empty? or user.length > 128
      return ERR_BAD_USERNAME
    end
    if password.length > 128
      return ERR_BAD_PASSWORD
    end
    if User.find_by_username(user).nil?
      u = User.create(:username => user, :password => password, :count => 1)
      return u.count
    else
      return ERR_USER_EXISTS
    end
  end
  
  def self.TESTAPI_resetFixture()
    User.delete_all
    return SUCCESS
  end
  
end
