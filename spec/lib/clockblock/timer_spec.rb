require File.expand_path('../../../spec_helper', __FILE__)

describe Clockblock::Timer do

  subject { Clockblock::Timer.new }

  describe "timer characteristics" do

    it "must be able to start" do
      subject.must_respond_to(:start)
    end

    it "must be able to stop" do
      subject.must_respond_to(:stop)
    end

    it "must have a started_at accessor" do
      subject.must_respond_to(:started_at)
    end

    it "must have a finished_at accessor" do
      subject.must_respond_to(:finished_at)
    end

    it "must have a duration accessor" do
      subject.must_respond_to(:duration)
    end

    it "must be able to clock" do
      subject.must_respond_to(:clock)
    end

    it "must have an attributes accessor" do
      subject.must_respond_to(:attributes)
    end

    it "must have a stage accessor" do
      subject.must_respond_to(:stage)
    end

  end

  describe "starting the timer" do
    before do
      @start_return_value = subject.start
    end

    let(:start_return_value) { @start_return_value }
    
    it "must return Time" do
      start_return_value.must_be_kind_of Time
    end

    it "must return the start time through the started_at accessor" do
      start_return_value.must_equal subject.started_at
    end

    it "must reset finished at and duration when it starts" do
      subject.finished_at.must_be_nil
      subject.duration.must_be_nil
    end

    it "must have a stage of :started" do
      subject.stage.must_equal :started
    end

  end

  describe "stopping the timer" do
    before do
      subject.start
      sleep 0.1
      @stop_return_value  = subject.stop
    end

    let(:started_at)        { subject.started_at }
    let(:stop_return_value) { @stop_return_value }
    let(:finished_at)       { subject.finished_at }

    it "must return an instance of Time" do
      stop_return_value.must_be_kind_of Time
    end

    it "must return the finish time through the finished_at accessor" do
      stop_return_value.must_equal finished_at
    end

    it "must have a stage of :finished" do
      subject.stage.must_equal :finished
    end

    specify "duration must be equal to the difference between start and finish" do
      subject.duration.must_equal finished_at - started_at
    end

  end

  describe "timer attributes" do
    let(:attributes)  { subject.attributes }

    it "must be a hash" do
      attributes.must_be_instance_of(Hash)
    end

    it "must have :started_at, :finished_at and :duration keys" do
      attributes.must_include(:started_at)
      attributes.must_include(:finished_at)
      attributes.must_include(:duration)
      attributes.must_include(:stage)
    end

  end

  describe "clocking a code block" do

    it "must return the result of the block" do
      expected = Random.rand(1)
      subject.clock{ expected }.must_equal expected
    end

    specify "stage must equal :error if the code block raises an error" do
      lambda{ subject.clock { raise } }.must_raise Clockblock::Timer::TimerException
      subject.stage.must_equal :error
    end

  end

end