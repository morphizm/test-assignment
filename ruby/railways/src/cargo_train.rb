class CargoTrain < Train
  def add_car(car)
    super(car) if car.instance_of? CargoCar
  end
end
