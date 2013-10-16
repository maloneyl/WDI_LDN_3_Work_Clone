# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Planet.delete_all

Planet.create!(name: 'Earth', moons: 1, orbit: 1.0, diameter: 1.0, mass: 1.0, planet_type: 'rocky', rings: false, image: 'http://upload.wikimedia.org/wikipedia/commons/thumb/9/97/The_Earth_seen_from_Apollo_17.jpg/540px-The_Earth_seen_from_Apollo_17.jpg')

Planet.create!(name: 'Mecury', moons: 0, orbit: 0.387, diameter: 0.3829, mass: 0.055, planet_type: 'rocky', rings: false, image: 'http://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Mercury_Globe-MESSENGER_mosaic_centered_at_0degN-0degE.jpg/540px-Mercury_Globe-MESSENGER_mosaic_centered_at_0degN-0degE.jpg')

Planet.create!(name: 'Venus', moons: 0, orbit: 0.723, diameter: 0.950, mass: 0.815, planet_type: 'rocky', rings: false, image: 'http://upload.wikimedia.org/wikipedia/commons/5/51/Venus-real.jpg')

Planet.create!(name: 'Mars', moons: 2, orbit: 1.524, diameter: 0.533, mass: 0.107, planet_type: 'rocky', rings: false, image: 'http://upload.wikimedia.org/wikipedia/commons/thumb/f/f7/Water_ice_clouds_hanging_above_Tharsis_PIA02653.jpg/500px-Water_ice_clouds_hanging_above_Tharsis_PIA02653.jpg')

Planet.create!(name: 'Jupiter', moons: 67, orbit: 5.204, diameter: 11.209, mass: 317.8, planet_type: 'gas-giant', rings: true, image: 'http://upload.wikimedia.org/wikipedia/commons/thumb/5/5a/Jupiter_by_Cassini-Huygens.jpg/520px-Jupiter_by_Cassini-Huygens.jpg')



