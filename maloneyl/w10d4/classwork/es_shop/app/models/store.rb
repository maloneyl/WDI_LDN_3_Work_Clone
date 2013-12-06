class Store
  include MongoMapper::Document
  include Tire::Model::Search # lets us search in elasticsearch
  include Tire::Model::Callbacks # gets stores automatically indexed (also triggered by destroy, not delete)
  include Geocoder::Model::MongoMapper # fixes incompatibility between Geocoder and MongoMapper

  key :address, String
  key :lon_lat, Array
  timestamps!

  geocoded_by :address, :coordinates => :lon_lat # method available through geocoder gem
  after_validation :geocode # auto-fetch coordinates

  # Tire lets us override ElasticSearch's way of auto-mapping data types
  mapping do
    indexes :address, type: "string"
    indexes :lon_lat, type: "geo_point"
  end

end
