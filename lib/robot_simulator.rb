require_relative 'simulator/command_parser'
require_relative 'simulator/interpreter'
require_relative 'simulator/robot'
require_relative 'simulator/simulator'
require_relative 'simulator/table'

def run(path)
  interpreter = Interpreter.new(path)
  simulator = Simulator.new

  interpreter.commands.each do |cmd|
    simulator.execute(cmd)
  end
end

run(ARGV[0]) if ARGV[0]
