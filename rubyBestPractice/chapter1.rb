class Question
  def ask(q)
    puts q
    res = gets.chomp
    case(res)
    when /^y(es)?$/i
      true
    when /^no?$/i
      false
    else
      puts "I dont understand"
    end
  end
end

q = Question.new
puts q.ask("Are you happy") ?"ok":"bad"
