require_relative 'instance_counter'
require_relative 'validation'

class Route
  attr_reader :stations
  include Validation
  include InstanceCounter

  validate :first_station, :type, Station
  validate :last_station, :type, Station

  def initialize(from, to)
    @stations = [from, to]
    validate!
    register_instances
  end

  def first_station
    @stations[0]
  end

  def last_station
    @stations[-1]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def remove_station(station)
    if station != first_station && station != last_station
      @stations.delete(station)
    end
  end

  def print_stations
    @stations.each { |station| puts station }
  end
end
# Убрал :stations из private, так как train использует этот метод
