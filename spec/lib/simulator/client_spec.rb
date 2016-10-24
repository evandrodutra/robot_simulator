require 'spec_helper'

describe Client do
  let(:commands) { ["PLACE 4,4,SOUTH\n", "REPORT\n"] }

  it 'starts a client and run commands' do
    allow(File).to receive(:exist?).with('commands.txt').and_return(true)
    allow(File).to receive(:readlines).with('commands.txt').and_return(commands)

    client = Client.new('commands.txt')
    expect { client.run }.to output("Output: 4,4,SOUTH\n").to_stdout
  end
end
