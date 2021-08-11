class PassengerTrain < Train
  TYPE = 'пассажирский'.freeze
  def add_car(places)
    validate!
    @number_cars << PassengerCars.new(places)
  end
end
