class Client
  def initialize(path)
    @path = path
  end

  def run
    interpreter = Interpreter.new(@path)
    simulator = Simulator.new

    interpreter.read!
    interpreter.commands.each do |cmd|
      simulator.execute(cmd)
    end
  end
end
