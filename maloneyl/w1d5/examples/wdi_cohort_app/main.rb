require "pry"
require "pry-byebug"

Dir[File.dirname(__FILE__) + '/models/*.rb'].each {|file| require file }

fred  = WdiStudent.new("Fred",  "12/12/1976")
harry = WdiStudent.new("Harry", "04/10/1991")
sally = WdiStudent.new("Sally", "01/02/1969")

fred.add_task_score  :calc_it,      35
fred.add_task_score  :mta,          56
fred.add_task_score  :happitails,   49

harry.add_task_score :calc_it,      58
harry.add_task_score :mta,          88
harry.add_task_score :happitails,   75

sally.add_task_score :calc_it,      99
sally.add_task_score :mta,          65
sally.add_task_score :happitails,   79

students = [
  fred,
  harry,
  sally
]

instructors = [
  WdiInstructor.new("Bob",      "04/10/1987"),
  WdiInstructor.new("Alice",    "17/09/1978"),
  WdiInstructor.new("Charlie",  "22/03/1981")
]

ga_nyc    = GaCampus.new("New York", "1/1/201")
ga_london = GaCampus.new("London",   "3/10/2012")

campuses = [ga_nyc, ga_london]

cohort = WdiCohort.new(students, instructors, ga_london, 100)

ga_london.cohorts << cohort

puts `clear`
puts ga_london
puts cohort

binding.pry
