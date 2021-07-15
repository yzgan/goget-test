require "test_helper"

class DeliveryJobFlowTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @delivery_job = delivery_jobs(:one)
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

  test 'view my delivery jobs' do
    get '/api/delivery_jobs', headers: { authorization: "bearer #{@user.generate_jwt}" }, as: :json
    assert_equal 200, status
    assert response.parsed_body['delivery_jobs'].present?
    delivery_job_response = response.parsed_body['delivery_jobs'][0]
    assert_equal delivery_job_response['id'], @delivery_job.id
    assert_equal delivery_job_response['pickup_address'], @delivery_job.pickup_address
    assert_equal delivery_job_response['dropoff_address'], @delivery_job.dropoff_address
  end
end
