class UserController < ApplicationController
  
  def login
    # unhandled exception need to render with status code 500?
    resp = User.login(@user.username, @user.password)
    if resp > 0
      render :json => {:errCode => error_code, :count => resp}
    else
      render :json => {:errCode => error_code}
    end
  end
  
  def add
    error_code = User.add(params[:user], params[:password])
    if error_code > 0
      render :json => {:errCode => error_code, :count => 1}
    else
      render :json => {:errCode => error_code} 
    end
  end
  
  def reset
    @hash = {}
    resp = User.TESTAPI_resetFixture()
    @hash[:errCode] = resp
    render :json => @hash
  end
  
  def test
    
  end
end
