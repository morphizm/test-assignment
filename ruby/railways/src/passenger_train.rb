class PassengerTrain < Train
  def add_car(car)
    super(car) if car.instance_of? PassengerCar
  end
end
