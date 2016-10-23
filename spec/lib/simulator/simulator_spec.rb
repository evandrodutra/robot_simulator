require 'spec_helper'

describe Simulator do
  let(:simulator) { Simulator.new }

  it 'instantiate with default Robot and Table 5x5' do
    expect(simulator.table.x).to eq(4)
    expect(simulator.table.y).to eq(4)
    expect(simulator.robot.placed?).to be_falsey
  end

  context '#commands' do
    let(:placed_robot) do
      robot = Robot.new
      robot.place!(1, 1, :north)
      robot
    end
    let(:simulator) { Simulator.new(Table.new(5, 5), placed_robot) }

    it 'executes PLACE' do
      simulator.execute(type: :place, x: 3, y: 3, f: :south)

      expect(simulator.robot.placed?).to be_truthy
      expect(simulator.robot.position).to eq(x: 3, y: 3, f: :south)
    end

    it 'does not PLACE the robot outside of the table' do
      simulator.execute(type: :place, x: 10, y: 10, f: :east)

      expect(simulator.robot.placed?).to be_truthy
      expect(simulator.robot.position).to eq(x: 1, y: 1, f: :north)
    end

    it 'executes MOVE' do
      simulator.execute(type: :move)

      expect(simulator.robot.position).to eq(x: 1, y: 2, f: :north)
    end

    it 'does not MOVE the robot to outside of the table' do
      simulator.execute(type: :place, x: 0, y: 0, f: :south)
      simulator.execute(type: :move)

      expect(simulator.robot.position).to eq(x: 0, y: 0, f: :south)
    end

    it 'executes TURN RIGHT' do
      simulator.execute(type: :turn, direction: :right)

      expect(simulator.robot.position).to eq(x: 1, y: 1, f: :east)
    end

    it 'executes TURN LEFT' do
      simulator.execute(type: :turn, direction: :left)

      expect(simulator.robot.position).to eq(x: 1, y: 1, f: :west)
    end

    it 'executes REPORT' do
      expect { simulator.execute(type: :report) }.to output("Output: 1,1,NORTH\n").to_stdout
    end

    it 'does not execute invalid command' do
      simulator.execute(type: :run)

      expect(simulator.robot.position).to eq(x: 1, y: 1, f: :north)
    end
  end

  context '#robot not placed' do
    it 'ignores MOVE command' do
      simulator.execute(type: :move)

      expect(simulator.robot.placed?).to be_falsey
    end

    it 'ignores TURN command' do
      simulator.execute(type: :turn, direction: :right)

      expect(simulator.robot.placed?).to be_falsey
    end

    it 'returns an empty report' do
      expect { simulator.execute(type: :report) }.to output("Output: \n").to_stdout
    end
  end

  context '#command list' do
    let(:parser) { Class.new.extend(CommandParser) }
    let(:commands) { parser.load(["MOVE\n", "MOVE\n", "PLACE 0,0,NORTH\n", "MOVE\n", "RIGHT\n", "MOVE\n", "LEFT\n", "MOVE\n"]) }

    it 'ignores commands until a valid PLACE command' do
      commands.each do |cmd|
        simulator.execute(cmd)
      end

      expect(simulator.robot.position).to eq(x: 1, y: 2, f: :north)
    end
  end
end
