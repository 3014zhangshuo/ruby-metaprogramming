# 计数器
def counter(n)
  proc { n + 1 }
end

a = counter(4)
p a.call
p a.call

# 测试题，请实现以下类EnuTest的功能
enu = EnuTest.new do |x|
  x << 1
  x << 3
  x << proc { 'hello' }
end

enu.next # => 1
enu.next # => 3
enu.next # => 'hello'
enu.next # => raise error 'EOF'

class EnuTest
  def initialize(&block)
    
  end
end

class EnuTest
  def initialize(&block)
    @eb = EnuBlock.new
    yield(@eb)
  end

  def next
    @eb.next
  end
end

class EnuBlock
  def initialize
    @blocks = []
  end

  def <<(object)
    if object.is_a?(Proc)
      @blocks << object
    else
      @blocks << proc { object }
    end
  end

  def next
    if @blocks.empty?
      raise 'EOF'
    else
      @blocks.shift.call
    end
  end
end
