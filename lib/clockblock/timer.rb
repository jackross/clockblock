module Clockblock
  class Timer
    attr_reader :started_at, :finished_at, :stage, :clockblock_result
 
    def initialize(opts = {})
      @stage = :initialized
      yield self if block_given?
    end

    def clock(name = "Anonymous Timer")
      begin
        start
        @stage = :executing
        @clockblock_result = yield
        stop
      rescue => ex
        @stage = :error
        raise TimerException.new("Error while executing '#{name}': '#{ex.message}'!")
      end
      @clockblock_result
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
      to_s
    end

    def to_s
      attributes.to_s
    end

    class TimerException < Exception
    end

  end
  
end