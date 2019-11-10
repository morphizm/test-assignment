require_relative 'producer'
require_relative 'instance_counter'
require_relative 'validation'

class Train
  attr_reader :speed, :number, :cars
  @@trains = {}
  NUMBER_FORMAT = /^[a-zA-Z0-9]{1}-?[a-zA-Z0-9]{2}$/
  include Producer
  include InstanceCounter
  include Validation

  def self.find(train_num)
    @@trains[train_num]
  end

  def initialize(number, cars = [])
    @number = number.to_s
    @cars = *cars
    @speed = 0
    validate!
    @@trains[number] = self
    register_instances
  end

  def decrease_speed(value)
    if @speed - value < 0
      @speed = 0
    else
      @speed -= value
    end
  end

  def increase_speed(value)
    @speed += value
  end

  def add_car(car)
    @cars << car if speed.zero?
  end

  def remove_car(car)
    @cars.delete(car) if speed.zero?
  end

  def route(route)
    @route = route
    @current_index_station = 0
    @route.first_station.take_train(self)
  end

  def to_next_station
    if next_station
      current_station.send_train(self)
      @current_index_station += 1
      current_station.take_train(self)
    end
  end

  def to_prev_station
    if prev_station
      current_station.send_train(self)
      @current_index_station -= 1
      current_station.take_train(self)
    end
  end

  def next_station
    if current_station != @route.last_station
      @route.stations[@current_index_station + 1]
    end
  end

  def prev_station
    if current_station != @route.first_station
      @route.stations[@current_index_station - 1]
    end
  end

  def current_station
    update_current_station_index
    @route.stations[@current_index_station]
  end

  def go_by_cars(&_block)
    cars.each { |car| yield(car) }
  end

  protected

  def update_current_station_index
    len = @route.stations.length
    if @current_index_station >= len
      @current_index_station = len - 1
    end
  end

  def validate!
    raise 'Number is not valid, format 000' if number !~ NUMBER_FORMAT
  end
end
# Убрал getter cars, эта функция должна быть доступна для пользователя по заданию
