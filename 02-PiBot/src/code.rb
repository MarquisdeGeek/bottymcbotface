require 'yaml'
require 'date'
require_relative 'pibot'

config = begin
	YAML.load(File.open('config/pibot.yml'))
rescue Exception => e
	puts "Sort out ya config: #{e.message}"
end

# 
# Main
#
bot = PiBot.new(config) 

msg = bot.generate

tweet = bot.post msg
#bot.reply tweet, botwords['replies'].sample

