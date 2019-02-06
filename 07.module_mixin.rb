require 'byebug'

module ActsAsField
  def self.included(base)
    base.include InstanceMethods
    base.extend ClassMethods
    base.class_eval do
      @@acts_as_fields = []
    end
  end

  module ClassMethods
    def field(name, path)
      result = class_variable_get(:@@acts_as_fields)
      result << name.to_sym
      class_variable_set(:@@acts_as_fields, result)

      # 定义实例方法
      define_method(name) do
        case path
        when String
          path.split(".").inject(self.latest_data) do |data, key|
            #byebug
            data[key]
          end
        when Proc
          path.call(self)
        end
      end
    end
  end

  module InstanceMethods
    def acts_as_fields
      self.class.class_variable_get :@@acts_as_fields
    end
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
