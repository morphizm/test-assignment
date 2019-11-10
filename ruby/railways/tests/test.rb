require 'test/unit'
require_relative '../src/station'
require_relative '../src/route'
require_relative '../src/train'
require_relative '../src/cargo_train'
require_relative '../src/passenger_train'
require_relative '../src/car'
require_relative '../src/cargo_car'
require_relative '../src/passenger_car'
# require_relative 'main.rb'
# require test_helper
# power-assert

class TrainTest < Test::Unit::TestCase
  def setup
    @station_moscow = Station.new('Moscow')
    @station_ek = Station.new('Ekaterinburg')
    @station_orel = Station.new('Orel')
    @route_mos_ek = Route.new(@station_moscow, @station_ek)
    @pas_train = PassengerTrain.new(411)
    @cg_train = CargoTrain.new('200')
    @pas_car = PassengerCar.new
    @cg_car = CargoCar.new
  end

  def test_stations
    assert_equal @station_moscow, @route_mos_ek.first_station
    assert_equal @station_ek, @route_mos_ek.last_station
  end

  def test_train_route
    @pas_train.route(@route_mos_ek)
    assert @station_moscow.trains.include?(@pas_train)
    assert @pas_train.cars.length.zero?
    assert_equal @station_ek, @pas_train.next_station
    @pas_train.to_next_station
    assert_equal @station_moscow, @pas_train.prev_station
    assert !@station_moscow.trains.include?(@pas_train)
    assert @station_ek.trains.include?(@pas_train)
  end

  def test_add_cars
    @pas_train.add_car(@pas_car)
    @cg_train.add_car(@cg_car)
    assert @pas_train.cars.include?(@pas_car)
    assert @cg_train.cars.include?(@cg_car)
    @pas_train.add_car(@cg_car)
    @cg_train.add_car(@pas_car)
    assert !@cg_train.cars.include?(@pas_car)
    assert !@pas_train.cars.include?(@cg_car)
    @pas_train.increase_speed(10)
    @pas_train.remove_car(@pas_car)
    assert @pas_train.cars.include?(@pas_car)
    @pas_train.decrease_speed(20)
    assert @pas_train.speed.zero?
    @pas_train.remove_car(@pas_car)
  end

  def test_route_train_station
    @route_mos_ek.add_station(@station_orel)
    @pas_train.route(@route_mos_ek)
    @pas_train.to_next_station
    @pas_train.to_next_station
    @route_mos_ek.remove_station(@station_orel)
    @pas_train.to_prev_station
    assert_equal @station_ek, @pas_train.next_station
  end
end
=begin
class ModTest < Test::Unit::TestCase
  def setup
    @station = Station.new('new')
    @station2 = Station.new('new2')
    @pas_train = PassengerTrain.new(400)
    @pass = PassengerTrain.new('s-ss')
    @cg_train = CargoTrain.new('bel')
    @cg_car = CargoCar.new
  end

  def test_mod
    company_name = 'camel'
    @pas_train.producer_name = company_name
    assert_equal company_name, @pas_train.producer_name
    @cg_car.producer_name = company_name
    assert_equal company_name, @cg_car.producer_name
    assert Station.all.length == 2
    assert_equal @pas_train, Train.find(400)
    assert_equal @cg_train, Train.find('bel')
    assert_equal nil, Train.find('undefined')
    assert Train.instances.zero?
    assert PassengerTrain.instances == 2
    assert Station.instances == 2
    @station3 = Station.new('third')
    assert Station.instances == 3
    assert Route.instances.zero?
    @route1 = Route.new(@station, @station2)
    assert Route.instances == 1
  end
end
=end
class ValidTest < Test::Unit::TestCase
  def setup
    @station = Station.new('new')
    @route = Route.new(@station, @station)
    @train = CargoTrain.new(633)
  end

  def test_valid
    assert @station.valid?
    assert @route.valid?
    assert @train.valid?
    assert_raise('RuntimeError') {
      # some code to trigger the error
      Route.new(@station, '')
    }
    assert_raise('RuntimeError') { PassengerTrain.new('w-ww sa') }
    assert_raise('RuntimeError') { Station.new('a_a') }
    assert_raise('RuntimeError') { Route.new('', @station) }
  end
end
#=begin
class BlockTest < Test::Unit::TestCase
  def setup
    @vagon = PassengerCar.new(10)
    @vagon1 = CargoCar.new(10)
    @vagon2 = CargoCar.new(1)
    @station = Station.new('name')
    @train = PassengerTrain.new('123')
    @train2 = CargoTrain.new('321')
    @go_by = Proc.new { |elem| elem }
  end

  def test_block
    @vagon.take_size(1)
    assert @vagon.free_size == 9
    assert @vagon.busy_size == 1
    @vagon.take_size(3)
    assert @vagon.busy_size == 2
    @vagon1.take_size(12)
    assert @vagon1.free_size == 0
    assert @vagon1.busy_size == 10
  end

  def test_block_station
    @station.take_train(@train)
    @station.take_train(@train2)
    #puts @station.trains
    assert_equal @station.go_by_trains(&@go_by), @station.trains
    @train2.add_car(@vagon1)
    @train2.add_car(@vagon2)
    assert_equal @train2.go_by_cars(&@go_by), @train2.cars
  end
end
#=end

class MetaTest < Test::Unit::TestCase
  def setup
    @vagon = PassengerCar.new(10)
    @vagon1 = CargoCar.new(10)
    @vagon2 = CargoCar.new(1)
    @station = Station.new('stat')
    @train = PassengerTrain.new('123')
    @train2 = CargoTrain.new('321')
  end

  def test_atr_acs
    assert @station.pack.nil?
    @station.pack = 3
    assert @station.pack == 3
  end

  def test_atr_strong
    assert @station.strong.nil?
    assert_raise("RuntimeError") {
      @station.strong = 'undefined'
    }
    @station.strong = 1
    assert_equal @station.strong, 1
  end

  def test_validate
    @station.pack = 4
    @station.pack = 5
    @station.pack = 7
    assert_equal @station.pack_history, [4, 5]
  end
end
