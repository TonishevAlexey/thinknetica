module InstanceCounter
  @@count = 0
  def self.included(base)
    base.send(:extend, InstanceCounter)

  end
  def instances
    @@count ||= 0
  end

  def accounting_instances
    register_instance
  end

  private
  def register_instance
    @@count += 1
  end
end

