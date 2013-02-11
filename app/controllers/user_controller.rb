class UserController < ApplicationController
  
  def login
    @user = User.new(params[:user])
    if @user.login(@user.username, @user.password) > 0
      respond_to do |format|
        format.json{render :json => @user, :errCode => 1, :count => @user.count}
      end
    else
      respond_to do |format|
        format.json{render :json => @user, :errCode => -1}
      end  
    end
  end
  
  def add
    @user = User.new(params[:user])
    if @user.add(@user.username, @user.password) > 0
      respond_to do |format|
        format.json{render :json => @user, :errCode => 1, :count => @user.count}
      end
    else
      respond_to do |format|
        format.json{render :json => @user, :errCode => -2}
      end  
    end
  end
  
  def reset
    @user = User.new(params[:user])
    if @user.TESTAPI_resetFixture() 
      respond_to do |format|
        format.json{render :json => @user, :errCode}
      end
    end
  end
  
end
