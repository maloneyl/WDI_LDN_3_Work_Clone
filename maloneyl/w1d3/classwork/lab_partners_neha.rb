class_members = [
  "Adam Buchan",
  "Alex Fasanmade",
  "Alex Hamlin",
  "Christos Shionis",
  "Clemens Kazda",
  "Daida Medina",
  "Jack Lalley",
  "Jamie Wallace",
  "Jonny Adshead",
  "Maloney Liu",
  "Neha Shah",
  "Oli Peate",
  "Ralph Reid",
  "Rob Forbes",
  "Selina Chotai",
  "Sharif Zu'bi",
  "Sophie Chitty",
  "Winna Bridgewater"].shuffle

puts "Hello! How many people do you want in each group?"
group_size = gets.chomp.to_i

class_members.each_slice(group_size) do |value| 
  p value
end