require_relative 'car'

class CargoCars < Car

  def available_volume
    self.places - self.busy
  end

end