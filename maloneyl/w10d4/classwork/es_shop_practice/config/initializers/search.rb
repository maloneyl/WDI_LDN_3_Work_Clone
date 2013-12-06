# Doing this at startup is STUPID! This should be a rake task
# but some hacks are needed because Tire doesn't really support single-table inheritance

Tire.index "products" do
  delete

  settings = {
    :index => {
      :analysis => {
        :analyzer => {
          :default_search => {
            :type => 'snowball' # popular text analyzer
          }
        }
      }
    }
  }

  common_mapping = {
    :properties => {
      :id             => {:type => 'string', :index    => :not_analyzed}, # because ids are string in mongo, don't bother searching these strings
      :name           => {:type => 'string', :analyzer => 'snowball', :boost => 100}, # boost means occurrence in this field is more significant than others
      :manufacturer   => {:type => 'string', :analyzer => 'snowball', :boost => 50},
      :description    => {:type => 'string', :analyzer => 'snowball'}
    }
  }

  product_mappings = {}
  [:product, :camera, :television].each do |product_type|
    product_mappings[product_type] = common_mapping
  end

  create :mappings => product_mappings, :settings => settings

end

Product.import
Store.import
