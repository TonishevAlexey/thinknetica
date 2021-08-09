class CargoTrain < Train
  TYPE =  "грузовой"

  def add_car(places)
    validate!
    @number_cars << CargoCars.new(places)

  end

end
