require 'pg'
require 'pry'

begin
  db = PG.connect(dbname: 'facebook', host: 'localhost')
  
  # with PG connected above, you can call. exec to run psql queries like SELECT...
  # db.exec("SELECT * FROM people") do |result| # result refers to that table we see in shell
  #   result.each do |row|
  #     p row
  #   end
  # end

  print "Full name: "
  name = gets.chomp.split # so that first and last names are split into an array
  print "Date of birth: "
  dob = gets.chomp
  print "City: "
  city = gets.chomp

  sql = "INSERT INTO people (first, last, dob, city) VALUES ('#{name[0]}', '#{name[1]}', '#{dob}', '#{city}')"
  db.exec(sql)

  db.exec("SELECT * FROM people") do |result|
     result.each do |row|
       p row
     end
  end

ensure
  db.close # again, v. important to close the db file

end # this is re: the begin…ensure…end