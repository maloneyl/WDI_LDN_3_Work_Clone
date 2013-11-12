Gallery.delete_all
Painting.delete_all

g = Gallery.create!(name: "Jon's Gallery", address: "London")
p = Painting.new(title: "Mona Lisa", remote_image_url: "http://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg/402px-Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg")

p.gallery = g
p.save!