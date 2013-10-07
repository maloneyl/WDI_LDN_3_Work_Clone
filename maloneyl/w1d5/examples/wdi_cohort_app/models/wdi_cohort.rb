class WdiCohort
  
  attr_accessor :students, :instructors, :number
  
  def initialize(students, instructors, campus, number)
    @students = students.sort
    @instructors = instructors.sort
    @campus = campus
    @number = number
  end
  
  def to_s
    puts "\n-------------------------------------------------------------\n\n"
    puts "COHORT: #{@campus.city} WDI #{@number}\n\n"
    
    puts "Student Biographies:\n\n"
    puts @students.map { |s| s.to_s }
    
    puts "\nInstructor Biographies:\n\n"
    puts @instructors.map { |i| i.to_s }
    puts "\n-------------------------------------------------------------\n\n"
  end
  
  def <=> (other)
    self.number <=> other.number
  end
  
end