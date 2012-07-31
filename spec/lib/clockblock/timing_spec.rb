require File.expand_path('../../../spec_helper', __FILE__)

describe Clockblock::Timing do
  describe "extending Clockblock::Timing in a class definition" do
    let(:ret_val) { 42 }

    def run_timing_specs(f)
      f.bar(ret_val).must_equal ret_val
      f.clockblock_timers.must_be_kind_of Hash
      f.clockblock_timers.keys.must_include :bar
      f.clockblock_timers[:bar].must_be_instance_of Clockblock::Timer
    end

    it "wraps an already defined method in a clock block" do
      
      foo_klass = Class.new do
        extend Clockblock::Timing

        def bar(ret_val)
          sleep 0.1; ret_val
        end
        add_timing_to :bar

      end

      run_timing_specs foo_klass.new

    end

    it "wraps an undefined method in a clock block" do
      
      foo_klass = Class.new do
        extend Clockblock::Timing
        add_timing_to :bar

        def bar(ret_val)
          sleep 0.1; ret_val
        end

      end

      run_timing_specs foo_klass.new

    end

    it "wraps a method defined 'after the fact' in a clock block" do
      
      foo_klass = Class.new do
        extend Clockblock::Timing
        add_timing_to :bar

      end

      foo_klass.class_eval do
        def bar(ret_val)
          sleep 0.1; ret_val
        end
      end

      run_timing_specs foo_klass.new

    end

    it "class can be extended 'after the fact' and still wrap a method defined in a clock block" do
      
      foo_klass = Class.new do
        def bar(ret_val)
          sleep 0.1; ret_val
        end
      end

      foo_klass.class_eval do
        extend Clockblock::Timing
        add_timing_to :bar
      end

      run_timing_specs foo_klass.new

    end
  end
end