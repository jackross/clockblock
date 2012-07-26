module Clockblock
  class Timer
    attr_reader :started_at, :finished_at, :stage
 
    def initialize(opts = {})
      @stage = :initialized
    end

    def clock(name = "Anonymous Timer")
      begin
        start
        @stage = :executing
        result = yield
        stop
      rescue => ex
        @stage = :error
        raise TimerException.new("Error while executing '#{name}': '#{ex.message}'!")
      end
      result
    end

    def start
      @finished_at = nil
      @stage = :started
      @started_at = Time.now
    end

    def stop
      @stage = :finished
      @finished_at = Time.now
    end

    def finish
      stop
    end

    def duration
      begin
        @finished_at - @started_at
      rescue
        nil
      end
    end
    
    def attributes
      { :started_at => started_at, :finished_at => finished_at, :duration => duration, :stage => stage }
    end

    def inspect
      attributes
    end

    def to_s
      attributes
    end

    class TimerException < Exception
    end

  end
  
end