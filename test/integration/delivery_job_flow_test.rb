require "test_helper"

class DeliveryJobFlowTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @delivery_job = delivery_jobs(:one)
    @delivery_job_other = delivery_jobs(:two)
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
    assert_equal 1, response.parsed_body['delivery_jobs'].size
    delivery_job_response = response.parsed_body['delivery_jobs'][0]
    assert_equal delivery_job_response['id'], @delivery_job.id
    assert_equal delivery_job_response['pickup_address'], @delivery_job.pickup_address
    assert_equal delivery_job_response['dropoff_address'], @delivery_job.dropoff_address
  end

  test 'view other delivery jobs' do
    get '/api/delivery_jobs/others', headers: { authorization: "bearer #{@user.generate_jwt}" }, as: :json
    assert_equal 200, status
    assert response.parsed_body['delivery_jobs'].present?
    assert_equal 1, response.parsed_body['delivery_jobs'].size
    delivery_job_response = response.parsed_body['delivery_jobs'][0]
    assert_equal delivery_job_response['id'], @delivery_job_other.id
    assert_equal delivery_job_response['pickup_address'], @delivery_job_other.pickup_address
    assert_equal delivery_job_response['dropoff_address'], @delivery_job_other.dropoff_address
  end

  test 'claim delivery job' do
    post "/api/delivery_jobs/#{@delivery_job_other.id}/claim", headers: { authorization: "bearer #{@user.generate_jwt}" }, as: :json
    assert_equal 200, status
    assert_equal @user.id, response.parsed_body['claimant_id']
  end

  test 'claim delivery job with claimant' do
    @delivery_job_other.update(claimant: @user)
    post "/api/delivery_jobs/#{@delivery_job_other.id}/claim", headers: { authorization: "bearer #{@user.generate_jwt}" }, as: :json
    assert_equal 422, status
    assert_equal 'Delivery job has been claimed', response.parsed_body['error']
  end
end
