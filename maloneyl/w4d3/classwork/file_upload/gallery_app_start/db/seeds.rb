Gallery.delete_all
Painting.delete_all

g1 = Gallery.create! name: "London Museum", address: "London"
g2 = Gallery.create! name: "Tate Modern", address: "London"
g3 = Gallery.create! name: "National Gallery", address: "London"

p1 = Painting.new title: "Mona Lisa", artist: "Leonardo da Vinci", description: "what a lovely smile", price: 100_000, image: "http://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg/402px-Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg"

p1.gallery = g1
p1.save!