module Clockblock
  module Timing

    module ClassMethods
      def add_timing_to *methods
        methods.each do |method|
          klass = self.is_a?(Class) ? self : (class << self; self; end)
          if klass.method_defined? method
            add_timing_to_method method, klass
          else
            @future_timer_methods ||= []
            @future_timer_methods << method
          end
        end
      end

      def add_timing_to_method(method, klass)
        stashed_method = "#{method}_stashed_by_clockblock".to_sym
        klass.class_eval do
          alias_method stashed_method, method
          define_method method do |*args, &block|
            @clockblock_timers ||= {}
            @clockblock_timers[method] = Clockblock::Timer.new

            @clockblock_timers[method].clock(method) do
              send stashed_method, *args, &block
            end
          end
        end
      end

      def method_added(method)
        if @future_timer_methods && @future_timer_methods.include?(method)
          unless @added_by_clockblock
            @added_by_clockblock = true
            klass = self.is_a?(Class) ? self : (class << self; self; end)
            add_timing_to_method method, klass
          end
          @added_by_clockblock = false
        end
      end
    end

    def self.extended(base)
      (base.is_a?(Class) ? base : base.class).send :attr_accessor, :clockblock_timers, :future_timer_methods
      base.send :extend, ClassMethods
    end

  end
end