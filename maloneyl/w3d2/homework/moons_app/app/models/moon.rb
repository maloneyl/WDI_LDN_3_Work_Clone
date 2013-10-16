class Moon < ActiveRecord::Base
  attr_accessible :associated_planet, :diameter, :image, :name

  def initialize name='', associated_planet='', image='', diameter=0.0
    @name = name
    @associated_planet = associated_planet
    @image = image
    @diameter = diameter
  end

end
