module Tasks

  class Task
  
    attr_accessor :time, :block, :called
    
    def initialize(time, block)
      @time = time
      @orig_time = time
      @block = block
      @called = false
    end
    
    def update
      @time -= 1
      (@block.call; @called = true) if @time <= 0
    end
    
    def reset
      @time = @orig_time
      @called = false
    end
  end

  @tasks = []
  @loop_tasks = []

  module_function
  
  def new_task(time, &block)
    @tasks << Task.new(time, block)
  end
  
  def new_task_loop(time, &block)
    @loop_tasks << Task.new(time, block)
  end
  
  def update
    return if @pause
    @tasks.each {|task|
      task.update
    }
    @tasks.collect! {|task| !task.called }
    @loop_tasks.each {|a|
      a.update
      a.reset if a.called
    }
  end
  
  def clear
    @tasks.clear
    @loop_tasks.clear
  end
  
  def pause
    @pause = true
  end
  
  def unpause
    @pause = false
  end
end