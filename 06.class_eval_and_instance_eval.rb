# class_eval => class_exec
# instance_eval => class_exec
# module_eval => module_exec
class Test
end

# 类的作用域
Test.class_eval do
  def self.name
    p 'A'
  end

  def child_name
    p 'a'
  end
end

Test.name
Test.new.child_name

# 实例作用域
Test.instance_eval do
  def real_name
    p 'z'
  end
end

Test.real_name

#######

class A
  B = "b"
  @@a = 1

  def a
    @@a
  end
end

A.class_eval "@@a = 2"
A.class_eval "B.replace('b2')"
# A.class_exec "B.replace('b2')" error

p A.new.a
p A::B

module B
  def self.included base
    p 'included...'

    base.class_eval do
      set_logger :hi
    end
  end

  def hi
    p 'hi'
  end
end

class C
  def self.set_logger method_name
    p method_name
  end

  include B
end
