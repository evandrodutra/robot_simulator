require_relative 'simulator/command_parser'
require_relative 'simulator/interpreter'
require_relative 'simulator/robot'
require_relative 'simulator/simulator'
require_relative 'simulator/table'
require_relative 'simulator/client'

Client.new(ARGV[0]).run if ARGV[0]
