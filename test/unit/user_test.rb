require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "adding a user" do
    assert User.add("vc1", "pw") == 1
  end
  
  test "adding a user that already exists" do
    res = User.add("vc2", "pw")
    assert User.add("vc2", "hello") == -2
  end
  
  test "adding user with empty username" do
    assert User.add("", "empty") == -3
  end
  
  test "adding a user with password> 128 chars" do
    pw = "a" * 130
    assert User.add("name", pw) == -4
  end
  
  test "adding a user with name > 128" do
    name = "b" * 140
    assert User.add(name, "pass") == -3
  end
  
  test "login" do
    User.add("vc", "hello")
    assert User.login("vc", "hello") == 2
  end
  
  test "login with nonexisting user" do
    User.add("vc", "ben")
    assert User.login("vc110", "hello") == -1
  end
  
  test "login 2 users" do
    User.add("eric", "jerry")
    User.add("jerry", "eric")
    assert User.login("eric", "jerry") == 2
    assert User.login("jerry", "eric") == 2
  end
  
  test "login a user multiple times" do
    User.add("vic", "word")
    assert User.login("vic", "word") == 2
    assert User.login("vic", "badpass") == -1
    assert User.login("vic", "word") == 3
    assert User.login("vic", "word") == 4
  end
  
  test "login with nonexistant user, then add and relogin" do
    assert User.login("george", "nec") == -1
    User.add("george", "nec")
    assert User.login("george", "nec") == 2
  end  
  
  test "reset fixture" do
    User.add("thisguy", "isgoingtogetdeleted")
    User.add("hello", "universe")
    User.add("what", "is goingon")
    assert User.TESTAPI_resetFixture() == 1
    assert User.login("hello", "universe") == -1
  end
end
