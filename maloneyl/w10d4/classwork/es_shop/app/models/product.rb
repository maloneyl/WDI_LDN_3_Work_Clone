class Product
  include MongoMapper::Document
  include Tire::Model::Search # lets us search in elasticsearch
  include Tire::Model::Callbacks # gets products automatically indexed (also triggered by destroy, not delete)

  key :name, String
  key :description, String
  key :manufacturer, String
  key :price, Integer
  timestamps!

  has_many :reviews

end
