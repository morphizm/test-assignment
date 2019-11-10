module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def acc
      @acc ||= []
    end

    def validate(*args)
      acc << args
    end
  end

  module InstanceMethods
    def validate!
      self.class.acc.each do |array|
        atr_to_check, valid_type, arg = array
        current = send(atr_to_check)
        send(valid_type, current, atr_to_check, arg)
      end
    end

    def presence(current, attribute, *_)
      raise "#{attribute} can not be nil or empty" \
        if current.nil? || current == ''
    end

    def type(current, attribute, klass)
      raise "#{attribute} type, #{current} is not instance of #{klass}" \
        unless current.instance_of? klass
    end

    def format(current, attribute, match)
      raise "#{attribute} format is not valid" if current !~ match
    end

    def valid?
      validate!
      true
    rescue
      false
    end
  end
end
