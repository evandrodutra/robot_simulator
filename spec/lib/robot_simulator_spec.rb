require 'spec_helper'

describe 'RobotSimulator' do
  let(:commands) { ["PLACE 4,4,SOUTH\n", "MOVE\n", "RIGHT\n", "REPORT\n"] }

  it 'runs the simulator with commands from a file' do
    allow(File).to receive(:exist?).with('commands.txt').and_return(true)
    allow(File).to receive(:readlines).with('commands.txt').and_return(commands)

    expect { run('commands.txt') }.to output("Output: 4,3,WEST\n").to_stdout
  end
end
