class PassengerTrain < Train
  TYPE = 'пассажирский'.freeze
  def add_car(places)
    validate!
    @number_cars << PassengerCars.new(places)
  end
end
PassengerTrain.new('11111')
PassengerTrain.new('22222')