namespace :morning do # like how the db ones have the namespace db(:thenthename)

  desc "Turn off the alarm" # yes, you describe the task first
  task :turn_off_alarm do # task takes its name as a symbol and a block
    puts "Turned off alarm. Would have liked 5 more minutes though."
  end

  desc "Brew like a barista"
  task :make_coffee do
    cups = ENV["COFFEE_CUPS"] || 2 # you can use environment variables in rake tasks
    puts "Made #{cups} cups of coffee."
  end

  # a rake task can include other rake tasks (similar to how db:setup does db:create, db:migrate, db:seed)
  desc "Do the whole morning routine"
  task :ready_for_the_day => [ :turn_off_alarm, :make_coffee ] do
    puts "Ready for the day now!"
  end

end
