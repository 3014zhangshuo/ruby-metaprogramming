require 'active_record'

class User < ActiveRecord::Base
  STATUS = %w[pending activated suspended]

  STATUS.each do |status|
    defind_method "is_#{status}?" do
      self.status == status
    end
  end
end
