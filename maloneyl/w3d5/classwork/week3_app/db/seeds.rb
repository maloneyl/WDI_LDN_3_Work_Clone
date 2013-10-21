# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

List.create name: :London
List.create name: :Work
List.create name: :Family

Contact.create name: :Luis, phone: 1234
Contact.create name: :Manuel, phone: 6789
Contact.create name: :Alejandro, phone: 9870
