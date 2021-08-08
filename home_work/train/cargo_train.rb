class CargoTrain < Train
  def add_car(places)
    validate!
    @number_cars << CargoCars.new(places)

  end

  def type
    "грузовой"
  end
end
