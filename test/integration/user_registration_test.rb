require "test_helper"

class UserRegistrationTest < ActionDispatch::IntegrationTest
  # fixtures :users

  test 'user registration' do
    params = {
      user: {
        email: 'user_1@gmail.com',
        name: 'user_1',
        password: 'password'
      }
    }
    post '/signup', params: params, as: :json
    assert_equal 200, status
    assert_equal params[:user][:email], response.parsed_body['email']
    assert_equal params[:user][:name], response.parsed_body['name']
    user = User.find_by(email: params[:user][:email])
    assert_equal user.id, response.parsed_body['id']
  end
end
