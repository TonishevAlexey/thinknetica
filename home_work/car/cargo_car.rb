require_relative 'car'

class CargoCars < Car
  def take_places(busy_places)
    self.busy_places = busy_places
  end
end
CargoCars.new(10)
CargoCars.new(20)