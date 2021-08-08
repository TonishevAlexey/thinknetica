require_relative 'car'

class PassengerCars < Car
  def take_places
    self.busy += 1
  end
  def free_places
    self.places - self.busy
  end
end

