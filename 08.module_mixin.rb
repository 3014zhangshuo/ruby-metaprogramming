require 'active_support/all'
module ActsAsField
  extend ActiveSupport::Concern

  included do
    #@@acts_as_fields = []
    class_attribute :acts_as_fields
    self.acts_as_fields = []
  end

  class_methods do
    def field(name, path)
      self.acts_as_fields << name
      # result = class_variable_get(:@@acts_as_fields)
      # result << name.to_sym
      # class_variable_set(:@@acts_as_fields, result)

      define_method(name) do
        case path
        when String
          path.split(".").inject(self.latest_data) { |data, key| data[key] }
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
