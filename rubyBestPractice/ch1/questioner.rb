class Questioner
  def inquire_about_happiness
    ask("Are you happy?") ? "Good" : "Bad"
  end

  def ask(question)
    puts question
    response = yes_or_no(gets.chomp)
    response.nil? ? ask(question) : response
  end

  def yes_or_no(response)
    case response
    when /^y(es)?$/i
      true
    when /^n(o)?$/i
      false
    end
  end

  def ask_with_io(q)
  end
end

