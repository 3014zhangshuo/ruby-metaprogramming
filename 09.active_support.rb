module Concern
  # base 为目标类 device
  def append_features(base)
    super
    base.instance_eval(&@_class_methods)
    base.class_eval(&@_class_eval)
  end

  def included(base=nil, &block)
    super
    @_class_eval = block
  end

  def class_methods &block
    @_class_methods = block
  end
end

module ActsAsField
  extend Concern

  included do
    @@acts_as_fields = []
  end

  class_methods do
    def field(name, path)
      result = class_variable_get(:@@acts_as_fields)
      result << name.to_sym
      class_variable_set(:@@acts_as_fields, result)

      define_method(name) do
        case path
        when String
          path.split(".").inject(self.latest_data) do |data, key|
            data[key]
          end
        when Proc
          path.call(self)
        end
      end
    end
  end


  def acts_as_fields
    self.class.class_variable_get :@@acts_as_fields
  end
end

class Device
  include ActsAsField

  field :device_type, "devise_type"
  field :battery, "data.battery"
  field :node_info, "data.node_info"
  field :battery_to_text, proc { |device|
    "#{device.battery}"
  }

  def latest_data
     {
       "data" => {
         "node_info" => "this is a sensor",
         "battery" => 90
       },
       "device_type" => "Sensor"
     }
  end
end

device = Device.new
p device.node_info
p device.battery_to_text
p device.acts_as_fields
