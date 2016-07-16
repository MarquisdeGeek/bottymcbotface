require 'yaml'
require_relative 'botty'

config = begin
	YAML.load(File.open('config/botty.yml'))	
rescue Exception => e
	puts "Sort out ya config: #{e.message}"
end

botwords = begin
	YAML.load(File.open('config/wordlist.yml'))	
rescue Exception => e
	puts "Sort out ya word list: #{e.message}"
end


# 
# Main
#

bot = BottyMcBotface.new(config) 
noun = botwords['nouns'][Date.today.yday % botwords['nouns'].length]
sentance = botwords['sentances'].sample
msg = bot.sentance(sentance, noun)

tweet = bot.post msg
bot.reply tweet, botwords['replies'].sample
