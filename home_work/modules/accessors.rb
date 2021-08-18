module Accessors

  def self.included(base)
    base.send(:extend, Accessors)
  end

  def self.extended(klass)
    class << klass
      attr_accessor :variables
    end
  end

  def attr_accessor_with_history(*attr)
    @variables_history ||= {}
    attr.each do |attr|
      get_attr attr
      save attr, variables
      attr_history attr, variables
    end
  end

  def strong_attr_accessor(attr, class_type)
    get_attr attr
    strong_set_attr attr, class_type
  end

  private

  def get_attr(attr)
    define_method(attr) do
      instance_variable_get "@#{attr}"
    end
  end

  def save(attr, history_storage)
    define_method("#{attr}=") do |value|
      self.class.send(:set_attr, attr, value)
      self.class.send(:save_value_attr, attr, value, history_storage)
    end
  end

  def strong_set_attr(attr, class_type)
    define_method("#{attr}=") do |value|
      value.instance_of?(class_type) ? self.class.send(:set_attr, attr, value) : raise('Некорректный класс!')
    end
  end

  def set_attr(attr, value)
    instance_variable_set "@#{attr}", value
  end

  def save_value_attr(attr, value, history_storage)
    variable_history = history_storage[attr]
    variable_history.nil? ? (history_storage[attr] = [value]) : variable_history << value
  end

  def attr_history(attr, history_storage)
    define_method("#{attr}_history") do
      history_storage[attr]
    end
  end
end
