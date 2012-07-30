[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/jackross/clockblock)



ClockBlock
==========

Extend ClockBlock::Timing in your class definition to add timers to your methods:

````ruby
require 'clockblock'

class Foo
  extend Clockblock::Timing
  add_timing_to :bar

  def bar
    sleep 2
  end

end

f = Foo.new
f.bar

f.clockblock_timers[:bar]
# => {:started_at=>2012-07-26 16:04:03 -0400, :finished_at=>2012-07-26 16:04:05 -0400, :duration=>2.001059, :stage=>:finished}

````

Extend your instances with ClockBlock::Timing to add timers to your methods:

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

f.clockblock_timers[:bar]
# => {:started_at=>2012-07-26 16:04:03 -0400, :finished_at=>2012-07-26 16:04:05 -0400, :duration=>2.001059, :stage=>:finished}

````

Extend your classes with ClockBlock::Timing to add timers to your methods:

````ruby
require 'clockblock'

class Foo
  def bar
    sleep 2
  end
end

Foo.extend Clockblock::Timing
Foo.add_timing_to :bar, :baz
puts Foo.instance_variable_get(:@future_timer_methods)
class Foo; def baz; sleep 1; end; end
f = Foo.new
f.bar
f.baz
puts f.clockblock_timers
# => {:bar=>{:started_at=>2012-07-30 10:43:48 -0400, :finished_at=>2012-07-30 10:43:49 -0400, :duration=>1.0004, :stage=>:finished}, :baz=>{:started_at=>2012-07-30 10:43:49 -0400, :finished_at=>2012-07-30 10:43:50 -0400, :duration=>1.000906, :stage=>:finished}}

````

Wrap your code in a Clock Block to measure execution duration.

````ruby
require 'clockblock'

class Foo

  def bar
    t = Clockblock::Timer.new
    result = t.clock do
      sleep 2 # replace 'sleep 2' with your code!
    end
    puts t.attributes
    result
  end
end

````

