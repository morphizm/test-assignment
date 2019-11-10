module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      @instances ||= 0
    end

    def add_instance(num)
      if !@instances
        @instances = num
      else
        @instances += num
      end
    end
  end

  module InstanceMethods
    protected
    def register_instances
      self.class.add_instance(1)
    end
  end
end
