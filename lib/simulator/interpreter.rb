class Interpreter
  attr_reader :commands

  def initialize(path)
    @path = path
    @commands = []
  end

  def read!
    return [] unless File.exist?(@path)

    lines = File.readlines(@path)
    command_parser = CommandParser.new

    @commands = command_parser.load(lines)
  end
end
