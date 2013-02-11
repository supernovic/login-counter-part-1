class UserController < ApplicationController
  
  def login
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.login(@user.username, @user.password) > 0
        format.json {}
      else
        format.json {}
      end
    end
  end
  
  def add
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.add(@user.username, @user.password) > 0
        format.json {}
      else
        format.json {}
      end
    end
  end
  
  def reset
    @user = User.new(params[:user])
    if @user.TESTAPI_resetFixture() > 0
      respond_to do |format|
        format.json{}
      end
    end
  end
  
  def test
  end
end
