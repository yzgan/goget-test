require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  fixtures :users

  test 'login successfully' do
    params = {
      user: {
        email: 'ganyizhong@gmail.com',
        password: 'password'
      }
    }
    post '/login', params: params, as: :json
    assert_equal 200, status
    assert response.parsed_body['token'].present?
  end
end
