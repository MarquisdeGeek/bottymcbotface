require 'twitter'

class BottyMcBotface  

  def initialize(settings)  
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = settings['consumer']['key']
      config.consumer_secret = settings['consumer']['secret']
      config.access_token = settings['access']['token']
      config.access_token_secret = settings['access']['secret']
    end
  end  
  
  def generate stub  
    stub.capitalize + 'y Mc' + stub.capitalize + 'face'
  end  

  def sentance sentance, stub
    msg = sentance.gsub! '$', stub 
    msg.gsub! '%', generate(stub)
    msg.gsub! "\\n", "\n"
    msg
  end

  def post message
    @client.update(message)
  end

  def reply tweet, message
    @client.update(".@#{tweet.user.screen_name} #{message}", in_reply_to_status_id: tweet.id)
  end

end  
