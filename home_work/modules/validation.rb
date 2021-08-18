module Validate
  @@validates = []

  def self.included(base)
    base.send(:extend, Validate)
  end

  def validate(validate_type, attr_name, option = nil)
    @@validates ||= []
    @@validates << {
      validate_type: validate_type, attr_name: attr_name, option: option
    }
  end

  def validate!
    @@validates.each do |validate_action|
      validate_type, attr_name, option = validate_action.values
      attr_value = send(:attr_value, attr_name)
      send(validate_type, attr_value, option)
    end
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  private

  def presence(attr_value, _)
    attr_value.nil? || attr_value.eql?('') ? raise('Передано значение nil или пустая строка.') : true
  end

  def format(attr_value, format)
    format.match?(attr_value) ? true : raise('Значение не соответствует формату.')
  end

  def type(attr_value, type)
    attr_value.instance_of?(type) ? true : raise('Передан не соответствующий тип')
  end

  def attr_value(attr_name)
    instance_variable_get("@#{attr_name}")
  end
end
