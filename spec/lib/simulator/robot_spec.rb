require 'spec_helper'

describe Robot do
  let(:robot) { Robot.new }

  it 'must have DIRECTIONS constants' do
    expect(Robot::DIRECTIONS).to eq([:north, :east, :south, :west])
  end

  it 'must have MOVES constants' do
    expect(Robot::MOVES).to eq(north: [0, 1], south: [0, -1], east: [1, 0], west: [-1, 0])
  end

  context '#placed' do
    let(:placed_robot) do
      robot.place!(1, 1, :north)
      robot
    end

    it 'must be true' do
      expect(placed_robot.placed?).to be_truthy
    end

    it 'must allow to turn left' do
      expect(placed_robot.position[:f]).to eq(:north)

      placed_robot.turn_left!

      expect(placed_robot.position[:f]).to eq(:west)
    end

    it 'must allow to turn right' do
      expect(placed_robot.position[:f]).to eq(:north)

      placed_robot.turn_right!

      expect(placed_robot.position[:f]).to eq(:east)
    end

    it 'must allow to move' do
      last_position = placed_robot.position
      placed_robot.move!

      expect(placed_robot.position).to_not eq(last_position)
    end

    it 'must allow replace' do
      last_position = placed_robot.position
      placed_robot.place!(2, 2, :west)

      expect(placed_robot.position).to_not eq(last_position)
    end

    it 'must preview move' do
      last_position = placed_robot.position

      expect(placed_robot.preview_move).to_not eq(last_position)
      expect(placed_robot.position).to eq(last_position)
    end

    it 'must report position' do
      expect(placed_robot.to_s).to eq('1,1,NORTH')
    end
  end

  context '#unplaced' do
    it 'must be false' do
      expect(robot.placed?).to be_falsey
    end

    it 'does not allow to turn left' do
      expect(robot.position[:f]).to be_nil

      robot.turn_left!

      expect(robot.position[:f]).to be_nil
    end

    it 'does not allow to turn right' do
      expect(robot.position[:f]).to be_nil

      robot.turn_right!

      expect(robot.position[:f]).to be_nil
    end

    it 'does not allow to move' do
      expect(robot.position).to be_empty

      robot.move!

      expect(robot.position).to be_empty
    end

    it 'must preview move' do
      expect(robot.preview_move).to be_empty
    end

    it 'must report position' do
      expect(robot.to_s).to_not be_nil
    end

    it 'must allow replace' do
      last_position = robot.position
      robot.place!(1, 1, :north)

      expect(robot.position).to_not eq(last_position)
    end
  end

  context '#turn' do
    it 'must turn to right from north' do
      robot.place!(1, 1, :north)
      robot.turn_right!

      expect(robot.position[:f]).to eq(:east)
    end

    it 'must turn to right from east' do
      robot.place!(1, 1, :east)
      robot.turn_right!

      expect(robot.position[:f]).to eq(:south)
    end

    it 'must turn to right from south' do
      robot.place!(1, 1, :south)
      robot.turn_right!

      expect(robot.position[:f]).to eq(:west)
    end

    it 'must turn to right from west' do
      robot.place!(1, 1, :west)
      robot.turn_right!

      expect(robot.position[:f]).to eq(:north)
    end

    it 'must turn to left from north' do
      robot.place!(1, 1, :north)
      robot.turn_left!

      expect(robot.position[:f]).to eq(:west)
    end

    it 'must turn to left from west' do
      robot.place!(1, 1, :west)
      robot.turn_left!

      expect(robot.position[:f]).to eq(:south)
    end

    it 'must turn to left from south' do
      robot.place!(1, 1, :south)
      robot.turn_left!

      expect(robot.position[:f]).to eq(:east)
    end

    it 'must turn to left from east' do
      robot.place!(1, 1, :east)
      robot.turn_left!

      expect(robot.position[:f]).to eq(:north)
    end
  end

  context '#move' do
    it 'must move one step to north' do
      robot.place!(1, 1, :north)
      robot.move!

      expect(robot.position[:x]).to eq(1)
      expect(robot.position[:y]).to eq(2)
    end

    it 'must move one step to east' do
      robot.place!(1, 1, :east)
      robot.move!

      expect(robot.position[:x]).to eq(2)
      expect(robot.position[:y]).to eq(1)
    end

    it 'must move one step to south' do
      robot.place!(1, 1, :south)
      robot.move!

      expect(robot.position[:x]).to eq(1)
      expect(robot.position[:y]).to eq(0)
    end

    it 'must move one step to west' do
      robot.place!(1, 1, :west)
      robot.move!

      expect(robot.position[:x]).to eq(0)
      expect(robot.position[:y]).to eq(1)
    end
  end
end
