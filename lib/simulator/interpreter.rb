class Interpreter
  include CommandParser

  attr_reader :commands

  def initialize(path)
    @path = path
    @commands = read_commands!
  end

  def read_commands!
    return [] unless File.exist?(@path)

    lines = File.readlines(@path)
    @commands = load(lines)
  end
end
