class Camera < Product # inheritance; single-table inheritance
  # include MongoMapper::Document # not necessary once we're doing inheritance

  index_name "products" # this method is available through Tire::Model::Search in Product

  key :resolution, String
  key :zoom, String
  key :weight, Integer

end
