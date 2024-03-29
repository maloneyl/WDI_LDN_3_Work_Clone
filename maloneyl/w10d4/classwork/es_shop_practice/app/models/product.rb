class Product
  include MongoMapper::Document

  include Tire::Model::Search
  include Tire::Model::Callbacks

  # mapping do
  #   indexes :id,           :index    => :not_analyzed
  #   indexes :name,         :analyzer => 'snowball', :boost => 100
  #   indexes :manufacturer, :analyzer => 'snowball', :boost => 50
  #   indexes :description,  :analyzer => 'snowball'
  # end

  key :name,          String
  key :description,   String
  key :manufacturer,  String
  key :price,         Integer
  timestamps!

  has_many :reviews

  def self.es_type
    model_name.underscore
  end

  def self.standard_facets
    {
      :rating       => Proc.new { terms :rating },
      :manufacturer => Proc.new { terms :manufacturer }
    }
  end

  def self.facets
    {
      :product_type => Proc.new { terms :product_type }
    }
  end

  # _type makes elasticsearch assume that you want your search results to be sorted by type
  # so here we map _type to product_type instead
  def to_indexed_json
    attr = attributes
    attr["product_type"] = attr.delete("_type") # when you delete an attribute in a hash, that gets returned before it's gone
    attr.to_json
  end

  def self.s(params, options={})

    # intialize search
    options.reverse_merge!(type: es_type) unless self == Product # only merge we're in the inherited models: camera, television or laptop (another trick to not have to write duplicate code in all those models)
    search = Tire::Search::Search.new('products', options)

    # set the query
    q = params[:q].present? ? params[:q] : nil

    bool_filters = []
    bool_filters += add_filters(params, search, "terms")
    bool_filters += add_filters(params, search, "range")
    bool_filters.flatten!

    main_fields = %w[name description manufacturer]

    if bool_filters.empty?
      search.query { q ? match(main_fields, q) : all }
    else
      search.query do
        boolean { |boolean| boolean.must { match(main_fields, q) } } if q
        bool_filters.each do |proc|
          boolean &proc
        end
      end
    end

    # add the facets
    facets.each do |name, block| # the block here refers to the proc
      search.facet name, &block # search is a tire search defined above
    end

    puts search.to_curl

    search
  end

private

  def self.add_filters(params, search, type)
    filters = params[type] || []
    filters.map do |name, details|
      values = []
      details.each do |value, checked|
        values << value if checked == "true"
      end
      send "add_#{type}_filters", name, values unless values.empty? # send is how you run a dynamic method in ruby!
    end.compact # add_range_filters could return nil
  end

  def self.add_terms_filters(name, values)
    Proc.new do |boolean|
      boolean.must { terms name, values }
    end
  end

  def self.add_range_filters(name, values)
    values.map do |value|
      kv_pairs = value.split("_").each_slice(2)
      range_params = kv_pairs.each_with_object({}) do |(k, v), hash|
        hash[k] = v.to_i
      end
      Proc.new do |boolean|
        boolean.must { range name, range_params }
      end
    end
  end

end
