require 'yaml'
require 'date'
require_relative 'wordbot'

config = begin
	YAML.load(File.open('config/wordbot.yml'))
rescue Exception => e
	puts "Sort out ya config: #{e.message}"
end

# 
# Main
#
bot = WordBot.new(config) 

msg = bot.generate

puts msg
#tweet = bot.post msg
#bot.reply tweet, botwords['replies'].sample

