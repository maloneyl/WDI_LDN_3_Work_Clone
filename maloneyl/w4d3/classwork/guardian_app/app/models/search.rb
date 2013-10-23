class Search < ActiveRecord::Base

  belongs_to :searchable, polymorphic: true
  # :searchable is created by textacular

  def self.new(query)
    return [] if query.empty? # return empty array if query is empty
    self.search(query).map!(&:searchable) # otherwise, perform a search and map it to the searchable
  end

  # 'magic' below...just believe. available at textacular.

  def readonly?; true; end
  
  def hash; [searchable_id, searchable_type].hash; end
  
  def eql?(result)
    searchable_id == result.searchable_id and searchable_type == result.searchable_type
  end

end
