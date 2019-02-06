a = "hello"

module B
  def hi
    p 'hi b'
  end
end

class A
  include B

  def hi
    super # 调用方法查找链上一层的同名方法
    p 'hi a'
  end
end

p A.ancestors
