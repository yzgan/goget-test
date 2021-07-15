class DeliveryJobsController < ApplicationController
  before_action :authenticate_user

  def create
    @delivery_job = current_user.delivery_jobs.new(delivery_job_params)

    if @delivery_job.save
      render @delivery_job, status: :created
    else
      render json: @delivery_job.errors, status: :unprocessable_entity
    end
  end

  private

  def delivery_job_params
    params
      .require(:delivery_job)
      .permit(:pickup_address, :pickup_latitude, :pickup_longitude, :dropoff_address, :dropoff_latitude, :dropoff_longitude)
  end
end
