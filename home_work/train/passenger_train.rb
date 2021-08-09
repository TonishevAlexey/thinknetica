class PassengerTrain < Train
  TYPE =  "пассажирский"
  def add_car(places)
    validate!
    @number_cars << PassengerCars.new(places)
  end
end
