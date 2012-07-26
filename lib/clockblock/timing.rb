module Clockblock
  module Timing

    def add_timing_to method
      stashed_method = "stashed_#{method}".to_sym
      timer_ivar = "@#{method}_timer".to_sym
      class_eval do
        alias_method stashed_method, method
        instance_variable_set timer_ivar, Clockblock::Timer.new
        define_method method do |*args, &block|

          timer_ivar.clock(method) do
            send stashed_method, *args, &block
          end

        end
      end
    end

  end
end