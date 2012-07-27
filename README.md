ClockBlock
==========

Wrap your code in a Clock Block to measure execution duration.

````ruby
require 'clockblock'

class Foo
  extend Clockblock::Timing

  def bar
    sleep 2
  end
  add_timing_to :bar

end

f = Foo.new
f.bar

f.clockblock_timers
# => {:bar=>{:started_at=>2012-07-26 16:04:03 -0400, :finished_at=>2012-07-26 16:04:05 -0400, :duration=>2.001059, :stage=>:finished}}

````

````ruby
require 'clockblock'

class Foo
  def bar
    sleep 2
  end
end

f = Foo.new
f.extend Clockblock::Timing
f.add_timing_to :bar
f.bar

f.clockblock_timers
# => {:bar=>{:started_at=>2012-07-26 16:04:03 -0400, :finished_at=>2012-07-26 16:04:05 -0400, :duration=>2.001059, :stage=>:finished}}

````

````ruby
class Foo1
  extend Clockblock::Timing
  add_timing_to :baz

  def bar
    sleep 1
  end
  add_timing_to :bar

  def baz
    sleep 1
  end
end

class Foo2
  def bar
    sleep 1
  end
end

class Foo3
  def bar
    sleep 1
  end
end

f1 = Foo1.new
f1.bar
puts f1.clockblock_timers
puts Foo1.instance_variable_get(:@future_timer_methods)

f2 = Foo2.new
f2.extend Clockblock::Timing
f2.add_timing_to :bar, :baz
f2.bar
puts f2.clockblock_timers
puts f2.instance_variable_get(:@future_timer_methods)

Foo3.extend Clockblock::Timing
Foo3.add_timing_to :bar, :baz
puts Foo3.instance_variable_get(:@future_timer_methods)
class Foo3; def baz; sleep 1; end; end
f3 = Foo3.new
f3.bar
f3.baz
puts f3.clockblock_timers
````