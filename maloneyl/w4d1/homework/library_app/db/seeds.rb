Library.delete_all
Bookshelf.delete_all
Book.delete_all

library1 = Library.create!(name: 'General Library', address: '1 Erudite Lane, Fancytown, AB1 CD2')

bookshelf1 = Bookshelf.create!(category: 'Fantasy Adventure')
library1.bookshelves << bookshelf1
library1.save

bookshelf2 = Bookshelf.create!(category: 'Behavioral Sciences')
library1.bookshelves << bookshelf2
library1.save

bookshelf3 = Bookshelf.create!(category: 'Philosophy')
library1.bookshelves << bookshelf3
library1.save

book1 = Book.create!(title: 'Life of Pi', author: 'Yann Martel', pages: 356, year: 2001)
bookshelf1.books << book1
bookshelf1.save

book2 = Book.create!(title: 'Thinking, Fast and Slow', author: 'Daniel Kahneman', pages: 512, year: 2011)
bookshelf2.books << book2
bookshelf2.save

book3 = Book.create!(title: 'The Architecture of Happiness', author: 'Alain de Botton', pages: 280, year: 2007)
bookshelf3.books << book3
bookshelf3.save

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
