require 'json'
require 'pp'

feelings = JSON.parse(File.read("data.json"), { :symbolize_names => true })

def pick_feeling(feelings)
  while true
    print_feelings(feelings)
    value = gets.to_i
    if value.between?(1, feelings[:children].count)
      return value
    else
      system "clear"
      puts "INVALID INPUT, CHOOSE AGAIN"
      next
    end
  end
end

def print_conclusion(feeling)
  puts "You're feeling #{feeling.downcase}! I hope this helped pinpoint what emotion you're feeling."
end

def print_feelings(feelings)
  (0..feelings[:children].count - 1).each do |i|
    print "(#{i + 1}) :: #{feelings[:children][i][:name]}\n"
  end
end

def get_feeling(feelings)
  count = 0
  until feelings[:children].nil?
    system "clear"
    puts 'How are you feeling right now? (Pick number)'
    puts "Press 0 if you feel \"#{feelings[:name]}\" best describes what you're feeling" if count >= 2

    value = pick_feeling(feelings)

    if value.between?(1, 9)
      feelings = feelings[:children][value - 1]
      count += 1
      next
    elsif value == 0
      return feelings
    end
  end
  feelings
end

feeling = get_feeling(feelings)[:name]
print_conclusion(feeling)
