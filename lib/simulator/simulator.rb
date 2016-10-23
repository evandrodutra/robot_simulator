class Simulator
  attr_reader :table, :robot

  def initialize(table = Table.new(5, 5), robot = Robot.new)
    @table = table
    @robot = robot
  end

  def execute(cmd)
    case cmd[:type]
    when :place  then place_robot(cmd[:x], cmd[:y], cmd[:f])
    when :move   then move_robot
    when :turn   then turn_robot(cmd[:direction])
    when :report then report
    end
  end

  def place_robot(x, y, f)
    @robot.place!(x, y, f) if @table.place_exist?(x, y)
  end

  def move_robot
    position = @robot.preview_move
    @robot.move! if @table.place_exist?(position[:x], position[:y])
  end

  def turn_robot(direction)
    case direction
    when :left then @robot.turn_left!
    when :right then @robot.turn_right!
    end
  end

  def report
    puts "Output: #{@robot}"
  end
end
