class A
  def self.hi
    p 'hi'
  end
end

class A
  class << self # 当前的作用域
    def hello
      p 'hello'
    end
  end
end

def A.hey
  p 'hey'
end

(class << A; self; end).class_eval do
  def you
    p 'you'
  end
end

A.singleton_class.class_eval do
  def folk
    p 'folk'
  end
end

# self
class B
  p self

  class << self
    p self
  end

  def hello
    p self
  end
end

B.new.hello

# variables

class C
  @a = 1
  @@b = 2

  def initialize
    @c = 3
    @@d = 4
  end

  class << self
    @e = 5
    @@f =6
  end

  def a
    @a
    @@e = 6
  end

  def c
    @c
  end

  def self.a
    @a
  end

  def c_variables
    [@@b, @@d, @@f]
  end
end

c = C.new

p C.instance_variables # => [:@a]
p C.class_variables # => [:@@b, :@@f, :@@d]

p c.instance_variables # => [:@c]
p c.singleton_class

p C.singleton_class.instance_variables # => [:@e]
p C.singleton_class.class_variables # => []
