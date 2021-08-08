class PassengerTrain < Train
  def add_car(places)
    validate!
    @number_cars << PassengerCars.new(places)

  end

  def type
    "пассажирский"
  end
end
