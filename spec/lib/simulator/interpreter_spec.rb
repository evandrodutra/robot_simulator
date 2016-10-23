require 'spec_helper'

describe Interpreter do
  let(:valid_commands) { ["PLACE 4,4,SOUTH\n", "REPORT\n", "MOVE\n", "RIGHT\n", "LEFT\n"] }
  let(:invalid_commands) { valid_commands + ["PLACE 2,2,NORTHWEST\n", "REPORT\n", "JUMP\n"] }
  let(:desired_commands) do
    [{ type: :place, x: 4, y: 4, f: :south }, { type: :report }, { type: :move },
     { type: :turn, direction: :right }, { type: :turn, direction: :left }]
  end

  it 'returns empty array if file does not exist' do
    allow(File).to receive(:exist?).with('invalid-file.txt').and_return(false)

    interpreter = Interpreter.new('invalid-file.txt')

    expect(interpreter.read_commands!).to eq([])
  end

  it 'returns valid commands' do
    allow(File).to receive(:exist?).with('valid-commands.txt').and_return(true)
    allow(File).to receive(:readlines).with('valid-commands.txt').and_return(valid_commands)

    valid_interpreter = Interpreter.new('valid-commands.txt')

    expect(valid_interpreter.commands).to eq(desired_commands)
  end

  it 'returns valid commands from file with invalid commands' do
    allow(File).to receive(:exist?).with('invalid-commands.txt').and_return(true)
    allow(File).to receive(:readlines).with('invalid-commands.txt').and_return(invalid_commands)

    invalid_interpreter = Interpreter.new('invalid-commands.txt')
    commands = desired_commands << { type: :report }

    expect(invalid_interpreter.commands).to eq(commands)
  end
end
