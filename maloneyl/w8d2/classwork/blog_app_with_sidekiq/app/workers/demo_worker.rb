class DemoWorker
  include Sidekiq::Worker # side note: modern gems tend to do include instead of inherit
  # sidekiq_options retry: 5 # how many times to retry; default is 25 (probably)
  sidekiq_options retry: false # usually you don't really bother with retries unless it's some external-related error, e.g. an API not responding at the moment

  def perform(delay, message)
    sleep delay
    logger.info message
  end
end
