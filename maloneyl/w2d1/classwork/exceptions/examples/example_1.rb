def run_example
  puts "about to divide 100 by 0"
  silly_calc
  puts "this string will never be printed"
end

def silly_calc
  100 / 0
end

run_example