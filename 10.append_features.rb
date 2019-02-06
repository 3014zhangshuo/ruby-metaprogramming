module A
  def self.included(target)
    v = target.instance_methods.include?(:method_name)
    puts "in included: #{v}"
  end

  def self.append_features(target)
    v = target.instance_methods.include?(:method_name)
    puts "in append features before: #{v}"
    super
    v = target.instance_methods.include?(:method_name)
    puts "in append features after: #{v}"
  end

  def method_name
  end
end

class X
 include A
end

# output
# in append features before: false
# in append features after: true
# in included: true
