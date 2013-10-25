require "twitter"
require "oauth"
Twitter.configure do |config|
    config.consumer_key = 'J1mynmuCMetvokKAUEb3aw'
    config.consumer_secret = 'xICbMpNo8aDK8ajIQ9iLz712eNy1XY5WIWBbCvFl7ho'
    config.oauth_token = '8417712-tJlfDyOxATMtSFMPnxnqGoXbplVGsQMkegHXqnSKfj'
    config.oauth_token_secret = '8417712-tJlfDyOxATMtSFMPnxnqGoXbplVGsQMkegHXqnSKfj'
end
Twitter.update(gets.chomp)