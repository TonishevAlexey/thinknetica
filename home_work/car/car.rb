require_relative '../modules/company'
require_relative '../modules/instance_counter'

class Car
  include Company
  attr_accessor :places, :busy

  def initialize(places)
    @places = places
    @busy = 0
  end

end
