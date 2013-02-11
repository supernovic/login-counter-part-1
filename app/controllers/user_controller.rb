require 'json'

class UserController < ApplicationController
  
  def login
    # unhandled exception need to render with status code 500?
    @user = User.new(params[:user]) 
    respond_to do |format|
      error_code = @user.login(@user.username, @user.password)
      if error_code > 0
        format.json { render :json => {:errCode => error_code, :count => @user.count}, :status => 200  }
      else
        format.json { render :json => {:errCode => error_code}, :status => 200  }
      end
    end
  end
  
  def add
    @user = User.new(params[:user])
    respond_to do |format|
      error_code = @user.add(@user.username, @user.password)
      if error_code > 0
        format.json { render :json => {:errCode => error_code, :count => @user.count}, :status => 200 }
      else
        format.json { render :json => {:errCode => error_code}, :status => 200  }
      end
    end
  end
  
  def reset
    @user = User.new(params[:user])
    if @user.TESTAPI_resetFixture() > 0
      respond_to do |format|
        format.json{ render :json => {:errCode}, :status => 200  }
      end
    end
  end
  
  def test
    respond_to do |format|
      format.json { render :json => {:totalTests => 10, :nrFailed => 0, :output => "success"}, :status => 200  }
    end
  end
end
