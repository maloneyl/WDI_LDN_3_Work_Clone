class Store

  include Tire::Model::Search
  include Tire::Model::Callbacks
  include MongoMapper::Document
  include Geocoder::Model::MongoMapper

  key :address, String
  key :lon_lat,  Array

  geocoded_by       :address, :coordinates => :lon_lat
  after_validation  :geocode  # auto-fetch coordinates

  mapping do # we can call Store.index.mapping in console
    indexes :address, type: 'string'
    indexes :lon_lat, type: 'geo_point'
  end

  timestamps!

  def self.s(params, options={})

    # set the query
    q = params[:q] || "London" # our search box has: {value: params[:q], :name => "q"}
    center_lon_lat = Geocoder.search(q).first.coordinates.reverse rescue [0, 0] # in-line rescue: [0, 0] is what's returned if rescue needed

    # perform search
    tire.search load: true do |s|
      s.query { all }
      s.sort do
        by :_geo_distance, {
          lon_lat: center_lon_lat ,
          order: "asc",
          unit: 'mi'
        }
      end
    end

  end

end
