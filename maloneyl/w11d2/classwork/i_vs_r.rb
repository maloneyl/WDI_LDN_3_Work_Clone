# ITERATIVE:
# def countdown(n)
#   while n >= 1 do
#     puts "iterative countdown " + n.to_s
#     n -= 1
#   end
# end


# RECURSIVE:
# def countdown(n)
#   if n <= 1 # base case
#     puts "recursive countdown " + n.to_s
#   else # base case isn't met
#     puts "recursive countdown " + n.to_s
#     countdown(n - 1) # will take us closer to the solution
#   end
# end

# countdown(10)


def r_factorial(n)
  if n <= 1 # base case
    1
  else
    n * r_factorial(n - 1)
  end
end

puts r_factorial(6)


