require File.expand_path('../../../spec_helper', __FILE__)

describe "extending Clockblock::Timing in a class definition" do
  it "wraps an already defined method in a clock block" do
    
    foo_klass = Class.new do
      extend Clockblock::Timing

      def bar
        sleep 1
      end
      add_timing_to :bar

    end

    f = foo_klass.new
    f.bar.must_equal 1
    f.clockblock_timers.must_be_kind_of Hash
    f.clockblock_timers.keys.must_include :bar
    f.clockblock_timers[:bar].must_be_instance_of Clockblock::Timer

  end

  it "wraps an undefined method in a clock block" do
    
    foo_klass = Class.new do
      extend Clockblock::Timing
      add_timing_to :bar

      def bar
        sleep 1
      end

    end

    f = foo_klass.new
    f.bar.must_equal 1
    f.clockblock_timers.must_be_kind_of Hash
    f.clockblock_timers.keys.must_include :bar
    f.clockblock_timers[:bar].must_be_instance_of Clockblock::Timer

  end
end