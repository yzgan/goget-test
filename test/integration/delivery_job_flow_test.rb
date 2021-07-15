require "test_helper"

class DeliveryJobFlowTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test 'create delivery' do
    params = {
      delivery_job: {
        pickup_address: 'No. 3, Jalan PJS 11/15, Bandar Sunway, 46150 Petaling Jaya, Selangor',
        pickup_latitude: '3.073018092768752',
        pickup_longitude: '101.60757435644045',
        dropoff_address: 'No. 3, Jalan PJS 11/15, Bandar Sunway, 46150 Petaling Jaya, Selangor',
        dropoff_latitude: '3.073018092768752',
        dropoff_longitude: '101.60757435644045'
      }
    }
    post '/api/delivery_jobs', params: params, headers: { authorization: "bearer #{@user.generate_jwt}" },
                               as: :json
    assert_equal 201, status
    assert_equal params[:delivery_job][:pickup_address], response.parsed_body['pickup_address']
    assert_equal params[:delivery_job][:pickup_latitude], response.parsed_body['pickup_latitude']
    assert_equal params[:delivery_job][:pickup_longitude], response.parsed_body['pickup_longitude']
    assert_equal params[:delivery_job][:dropoff_address], response.parsed_body['dropoff_address']
    assert_equal params[:delivery_job][:dropoff_latitude], response.parsed_body['dropoff_latitude']
    assert_equal params[:delivery_job][:dropoff_longitude], response.parsed_body['dropoff_longitude']
    assert_equal @user.id, response.parsed_body['user_id']
  end
end
