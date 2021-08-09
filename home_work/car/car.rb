require_relative '../modules/company'
require_relative '../modules/instance_counter'

class Car
  include Company
  attr_accessor :places, :busy_places

  def initialize(places)
    @places = places
    @busy_places = 0
  end
  def free_places
    self.places - self.busy_places
  end
  def take_places(busy_places)
    raise "Not implement in current realisation"
  end
end
