class CargoTrain < Train
  TYPE = 'грузовой'.freeze

  def add_car(places)
    validate!
    @number_cars << CargoCars.new(places)
  end
end
CargoTrain.new("33-333")
CargoTrain.new("44-444")