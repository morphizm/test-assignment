require_relative 'producer'

class Car
  include Producer
  attr_reader :size, :busy_size

  def initialize(size = 0)
    @size = size
    @busy_size = 0
  end

  def take_size(taking_size = 1)
    @busy_size += taking_size > free_size ? free_size : taking_size
  end

  def free_size
    size - busy_size
  end
end
