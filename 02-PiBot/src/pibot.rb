require 'twitter'
require 'date'

class PiBot 

  def initialize(settings)  
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = settings['consumer']['key']
      config.consumer_secret = settings['consumer']['secret']
      config.access_token = settings['access']['token']
      config.access_token_secret = settings['access']['secret']
    end

    @suffix = " #pi #pibot"
    @start_on = Date.parse("2017-07-22")
  end  
  
  def generate
    pidata = File.read('config/pi')

    days_since = (Date.today - @start_on).to_i
    tweet_size = 140 - @suffix.length

    msg = pidata.slice(days_since * tweet_size, tweet_size)
    msg << @suffix
  end

  def post message
    @client.update(message)
  end

  def reply tweet, message
    @client.update(".@#{tweet.user.screen_name} #{message}", in_reply_to_status_id: tweet.id)
  end

end  
