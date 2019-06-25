class WordListGenerate
  def initialize
    target = 'config/words'

    @prefix = "Experimenting with"
    @suffix = " #feedmyfavourites"

    start_new = true
    msg = ""
    day = 0

    File.open("/usr/share/dict/words").each do |line|
      word = "##{line.strip!} "
      tweet_size = (msg.length + @suffix.length + word.length)
      if (tweet_size > 280)
        msg += "#{@suffix}"
        File.write("#{target}/#{day.to_s.rjust(4, "0")}", msg)
        start_new = true
        day += 1
      end

      msg = "#{@prefix} " if start_new
      msg += "#{word}"

      start_new = false
    end

  end
end

gen = WordListGenerate.new()

