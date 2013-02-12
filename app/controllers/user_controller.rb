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
    resp = User.TESTAPI_resetFixture()
    render :json => {:errCode => resp}
  end
  
  def test
    @hash = {}
    index = 0
    test_results = `ruby -Itest test/unit/user_test.rb`
    @hash[:output] = test_results
    test_results.scan(/(\d+)\stests|(\d+)\sassertions|(\d+)\sfailures|(\d+)\serrors/).flatten.each { |num| 
      if !num.nil?
        if index == 0
          @hash[:totalTests] = num.to_i
        elsif index == 2
          @hash[:nrFailed] = num.to_i
        end
        index += 1
      end
    }
    render :json => @hash
  end
end
