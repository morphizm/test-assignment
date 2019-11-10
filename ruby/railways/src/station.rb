require_relative 'instance_counter'
require_relative 'validation'
require_relative 'accessors'

class Station
  @@all = []
  attr_reader :trains, :name
  NAME_FORMAT = /^[a-zA-Z0-9]+$/
  include InstanceCounter
  include Validation
  include Accessors

  attr_accessor_with_history :pack
  strong_attr_accessor :strong, Integer

  validate :name, :format, NAME_FORMAT
  validate :name, :presence
  def self.all
    @@all
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@all << self
    register_instances
  end

  def take_train(train)
    @trains << train
  end

  def trains_list_type(type)
    @trains.select { |train| train.type == type }
  end

  def send_train(train)
    @trains.delete(train)
  end

  def go_by_trains(&_block)
    trains.each { |train| yield(train) }
  end
end
# Ничего не стал защищать,
# так как все эти функции должны быть доступны по заданию для полльзователя
