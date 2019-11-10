module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*items)
      items.each do |item|
        name = "@#{item}".to_sym
        name_history = "@#{item}_history".to_sym
        define_method(item) { instance_variable_get(name) }
        define_method("#{item}_history".to_sym) { instance_variable_get(name_history) }
        define_method("#{item}=".to_sym) do |value|
          if instance_variable_get(name_history).nil?
            instance_variable_set(name_history, [])
          end
          unless instance_variable_get(name).nil?
            instance_variable_get(name_history) << instance_variable_get(name)
          end
          instance_variable_set(name, value)
        end
      end
    end

    def strong_attr_accessor(atr, klass)
      name = "@#{atr}".to_sym
      define_method(atr) { instance_variable_get(name) }
      define_method("#{atr}=".to_sym) do |value| 
        raise "#{value} is not instance of #{klass}" unless value.instance_of? klass
        instance_variable_set(name, value)
      end
    end
  end
end
