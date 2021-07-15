json.delivery_job do |json|
  json.partial! 'delivery_jobs/delivery_job', delivery_job: @delivery_job
end
