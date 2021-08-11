require_relative 'car'

class PassengerCars < Car
  def take_places(busy_places = 1)
    self.busy_places += 1
  end
end
