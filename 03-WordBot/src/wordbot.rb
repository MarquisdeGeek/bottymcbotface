require 'twitter'
require 'time'

class WordBot 

  def initialize(settings)  
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = settings['consumer']['key']
      config.consumer_secret = settings['consumer']['secret']
      config.access_token = settings['access']['token']
      config.access_token_secret = settings['access']['secret']
    end

    @start_on = Time.parse("2019-06-24 12:54:00")
  end  
  
  def generate
    # the time gives us second - we /60 to get minutes, and /60 to get hours
    hrs_since = (Time.now - @start_on).to_i / (60*60)
    msg = File.read("config/words/#{hrs_since.to_s.rjust(4,'0')}")
  end

  def post message
    @client.update(message)
  end

  def reply tweet, message
    @client.update(".@#{tweet.user.screen_name} #{message}", in_reply_to_status_id: tweet.id)
  end

end  
