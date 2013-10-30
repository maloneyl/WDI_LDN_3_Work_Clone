require 'spec_helper'

describe Gallery do 

  describe 'validations' do 
    it { should validate_presence_of(:name) } # tests if our model's gallery.rb has vadliates_presence_of :name
  end

end