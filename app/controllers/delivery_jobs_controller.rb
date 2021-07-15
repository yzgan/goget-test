class DeliveryJobsController < ApplicationController
  before_action :authenticate_user
  before_action :set_delivery_job, only: %i[claim execute]

  def index
    @delivery_jobs = current_user.delivery_jobs
  end

  def create
    @delivery_job = current_user.delivery_jobs.new(delivery_job_params)

    if @delivery_job.save
      render @delivery_job, status: :created
    else
      render json: @delivery_job.errors, status: :unprocessable_entity
    end
  end

  def others
    @delivery_jobs = DeliveryJob.where.not(user_id: current_user.id)
  end

  def claim
    @delivery_job.with_lock do
      return render_error_message('Delivery job has been claimed') if @delivery_job.claimant.present?
      return render_error_message('Delivery job has been executed') if @delivery_job.executed?

      @delivery_job.claimant = current_user
      if @delivery_job.save
        render @delivery_job
      else
        render json: @delivery_job.errors, status: :unprocessable_entity
      end
    end
  end

  def execute
    return render_error_message('Delivery job not claimed by user') unless @delivery_job.claimant == current_user

    if @delivery_job.update(status: :executed)
      render @delivery_job
    else
      render json: @delivery_job.errors, status: :unprocessable_entity
    end
  end

  private

  def set_delivery_job
    @delivery_job = DeliveryJob.find params[:id]
  end

  def delivery_job_params
    params
      .require(:delivery_job)
      .permit(:pickup_address, :pickup_latitude, :pickup_longitude, :dropoff_address, :dropoff_latitude, :dropoff_longitude)
  end
end
