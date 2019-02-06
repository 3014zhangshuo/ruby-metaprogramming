class A
end

# 任何属性自动添加getter setter
# A.title = "zhangshuo"
# A.title

class A
  @@attributes = {}

  def self.title
    @@attributes[:title]
  end

  def self.title=(value)
    @@attributes[:title] = value
  end
end

A.title = "zhangshuo"
A.title

class A
  @@attributes = {}

  # 类的 method_missing
  class << self
    def method_missing(method_name, *params)
      method_name = method_name.to_s
      if method_name =~ /=$/
        @@attributes[method_name.sub('=', '')] = params.first
      else
        @@attributes[method_name]
      end
    end
  end
end

module B
  def hello
    p 'hello'
  end

  def method_missing(name)
    p name
  end
end

class C
  include B

  def hi
    p 'hi'
  end
end

c = C.new
c.hi
c.hello
c.zhangshuo
