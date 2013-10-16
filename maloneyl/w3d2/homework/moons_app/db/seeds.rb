# name:string associated_planet:string image:text diameter:float

m1 = Moon.create!(name: 'Europa', associated_planet: 'Jupiter', image: 'http://upload.wikimedia.org/wikipedia/commons/5/54/Europa-moon.jpg', diameter: 3100.0)
m2 = Moon.create!(name: 'Io', associated_planet: 'Jupiter', image: 'http://upload.wikimedia.org/wikipedia/commons/7/7b/Io_highest_resolution_true_color.jpg', diameter: 3642.0)
m3 = Moon.create!(name: 'Dione', associated_planet: 'Saturn', image: 'http://upload.wikimedia.org/wikipedia/commons/c/c6/Dione_%28Mond%29_%2830823363%29.jpg', diameter: 1123.0)
m4 = Moon.create!(name: 'Moon', associated_planet: 'Earth', image: 'http://upload.wikimedia.org/wikipedia/commons/e/e1/FullMoon2010.jpg', diameter: 3474.8)
m5 = Moon.create!(name: 'Phobos', associated_planet: 'Mars', image: 'http://upload.wikimedia.org/wikipedia/commons/5/5c/Phobos_colour_2008.jpg', diameter: 26.0)
m6 = Moon.create!(name: 'Ariel', associated_planet: 'Uranus', image: 'http://upload.wikimedia.org/wikipedia/commons/2/23/Ariel-NASA.jpg', diameter: 1168.0)
m7 = Moon.create!(name: 'Proteus', associated_planet: 'Neptune', image: 'http://upload.wikimedia.org/wikipedia/commons/f/f4/Proteus_Voyager_2_croped.jpg', diameter: 420.0)

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
