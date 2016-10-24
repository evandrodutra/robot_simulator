require 'spec_helper'

describe CommandParser do
  let(:command) { CommandParser.new }
  let(:valid_commands) { ["PLACE 4,4,SOUTH\n", "REPORT\n", "MOVE\n", "RIGHT\n", "LEFT\n"] }
  let(:invalid_commands) { valid_commands + ["PLACE 2,2,NORTHWEST\n", "REPORT\n", "JUMP\n"] }

  context '#load' do
    it 'must parse commands from a list of lines' do
      loaded_commands = command.load(valid_commands)
      desired_commands = [{ type: :place, x: 4, y: 4, f: :south }, { type: :report }, { type: :move },
                          { type: :turn, direction: :right }, { type: :turn, direction: :left }]

      expect(loaded_commands).to eq(desired_commands)
    end

    it 'must ignore invalid commands' do
      parsed_list = command.load(invalid_commands)

      expect(invalid_commands.size).not_to eq(parsed_list.size)
      expect(parsed_list.map { |c| c[:type] }).to eq([:place, :report, :move, :turn, :turn, :report])
    end
  end

  context '#parse' do
    it 'must accept the PLACE command' do
      expect(command.parse('PLACE 1,2,NORTH')).to eq(type: :place, x: 1, y: 2, f: :north)
      expect(command.parse('PLACE 1,2,SOUTH')).to eq(type: :place, x: 1, y: 2, f: :south)
      expect(command.parse('PLACE 1,2,EAST')).to eq(type: :place, x: 1, y: 2, f: :east)
      expect(command.parse('PLACE 1,2,WEST')).to eq(type: :place, x: 1, y: 2, f: :west)
    end

    it 'must accept the MOVE command' do
      expect(command.parse('MOVE')).to eq(type: :move)
    end

    it 'must accept the LEFT command' do
      expect(command.parse('LEFT')).to eq(type: :turn, direction: :left)
    end

    it 'must accept the RIGH command' do
      expect(command.parse('RIGHT')).to eq(type: :turn, direction: :right)
    end

    it 'must accept the REPORT command' do
      expect(command.parse('REPORT')).to eq(type: :report)
    end

    it 'must ignore invalid commands' do
      expect(command.parse('PLACE1,2,NORTH')).to be_nil
      expect(command.parse('PLACE a,b,NORTH')).to be_nil
      expect(command.parse('PLACE 1,2,NORTWEST')).to be_nil
      expect(command.parse('JUMP')).to be_nil
    end
  end
end
