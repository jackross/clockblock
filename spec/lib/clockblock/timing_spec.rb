require File.expand_path('../../../spec_helper', __FILE__)

describe Clockblock::Timing do
  let(:ret_val) { 42 }

  def run_timing_specs_on(f, *methods)
    methods.each do |method|
      f.send(method, ret_val).must_equal ret_val
      f.clockblock_timers.must_be_kind_of Hash
      f.clockblock_timers.keys.must_include method
      f.clockblock_timers[method].must_be_instance_of Clockblock::Timer
    end
  end

  describe "extending Clockblock::Timing in a class definition" do

    it "wraps an already defined method in a clock block" do
      
      foo_klass = Class.new do
        extend Clockblock::Timing

        def bar(ret_val); sleep 0.1; ret_val; end
        add_timing_to :bar
      end

      run_timing_specs_on foo_klass.new, :bar

    end

    it "eventually wraps an as yet undefined method in a clock block" do
      
      foo_klass = Class.new do
        extend Clockblock::Timing
        add_timing_to :bar

        def bar(ret_val); sleep 0.1; ret_val; end
      end

      run_timing_specs_on foo_klass.new, :bar

    end

    it "wraps multiple methods in a clock block" do
      
      foo_klass = Class.new do
        extend Clockblock::Timing
        add_timing_to :bar, :baz

        def bar(ret_val); sleep 0.1; ret_val; end
        def baz(ret_val); sleep 0.1; ret_val; end
      end

      run_timing_specs_on foo_klass.new, :bar, :baz

    end

    it "wraps a method defined 'after the fact' in a clock block" do
      
      foo_klass = Class.new do
        extend Clockblock::Timing
        add_timing_to :bar
      end

      foo_klass.class_eval{ def bar(ret_val); sleep 0.1; ret_val; end }

      run_timing_specs_on foo_klass.new, :bar

    end

    it "class can be extended 'after the fact' and still wrap a method defined in a clock block" do
      
      foo_klass_a = Class.new{ def bar(ret_val); sleep 0.1; ret_val; end }
      foo_klass_b = Class.new{ def bar(ret_val); sleep 0.1; ret_val; end }

      # try it one way
      foo_klass_a.class_eval do
        extend Clockblock::Timing
        add_timing_to :bar
      end

      run_timing_specs_on foo_klass_a.new, :bar

      # try it the other way
      foo_klass_b.extend Clockblock::Timing
      foo_klass_b.add_timing_to :bar

      run_timing_specs_on foo_klass_b.new, :bar

    end
  end

  describe "extending Clockblock::Timing with an instance" do

    it "wraps a defined method in a clock block" do
      
      foo_klass = Class.new{ def bar(ret_val); sleep 0.1; ret_val; end }

      f = foo_klass.new
      f.extend Clockblock::Timing
      f.add_timing_to :bar

      run_timing_specs_on f, :bar

    end

    it "eventually wraps an undefined method in a clock block" do

      foo_klass = Class.new

      f = foo_klass.new
      f.extend Clockblock::Timing
      f.add_timing_to :bar

      def f.bar(ret_val); sleep 0.1; ret_val; end

      run_timing_specs_on f, :bar

    end

  end

end