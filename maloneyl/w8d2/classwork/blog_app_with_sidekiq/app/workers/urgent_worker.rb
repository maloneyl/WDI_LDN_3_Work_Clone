class UrgentWorker
  include Sidekiq::Worker

  sidekiq_options retry: false, queue: :urgent

  def perform(delay, message)
    sleep delay
    logger.info message
  end
end
