# to re-seed, put .delete_all at the top
# Movie.delete_all
# Actor.delete_all

Movie.create!(title: 'Blue Jasmine', release_date: '27 Sep 2013', poster: 'http://upload.wikimedia.org/wikipedia/en/3/3f/Blue_Jasmine_poster.jpg', director: 'Woody Allen', rating: 9)
Movie.create!(title: 'Napoleon Dynamite', release_date: '26 Dec 2004', poster: 'http://upload.wikimedia.org/wikipedia/en/8/87/Napoleon_dynamite_post.jpg', director: 'Jared Hess', rating: 7)

Actor.create!(first_name: 'Cate', last_name: 'Blanchett', birthdate: '14 May 1969')
Actor.create!(first_name: 'Jon', last_name: 'Heder', birthdate: '26 Oct 1977')

# To be able to seed the join table too, make sure to use variables so that you can do things like
# movie1 = Movie.create!(...)
# actor1 = Actor.create!(...)
# actor1.movies = [movie1, movie2]
# actor1.save
# movie1.actors << actor1
# REMEMBER: we are adding stuff to an ARRAY so we need to either '= []' or '<<'