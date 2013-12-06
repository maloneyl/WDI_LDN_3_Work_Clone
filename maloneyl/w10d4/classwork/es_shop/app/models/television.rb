class Television < Product
  # include MongoMapper::Document

  index_name "products"

  key :tech, String
  key :size, String
  key :format, String
  key :feature, String

end
