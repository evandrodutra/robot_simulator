class Robot
  DIRECTIONS = [:north, :east, :south, :west].freeze
  MOVES = { north: [0, 1], south: [0, -1], east: [1, 0], west: [-1, 0] }.freeze

  attr_reader :position

  def initialize
    @position = {}
    @placed = false
  end

  def place!(x, y, f)
    return unless DIRECTIONS.include?(f)

    @placed = true
    @position = { x: x, y: y, f: f }
  end

  def placed?
    @placed
  end

  def turn_left!
    @position[:f] = DIRECTIONS[DIRECTIONS.index(@position[:f]) - 1] if placed?
  end

  def turn_right!
    return unless placed?

    index = DIRECTIONS.index(@position[:f])
    index = (index == DIRECTIONS.size - 1) ? 0 : index + 1

    @position[:f] = DIRECTIONS[index]
  end

  def move!
    @position = preview_move if placed?
  end

  def preview_move
    return {} unless placed?

    axis = MOVES[@position[:f]]

    {
      x: @position[:x] + axis[0],
      y: @position[:y] + axis[1],
      f: @position[:f]
    }
  end

  def to_s
    @position.values.map { |v| v.to_s.upcase }.join(',')
  end
end
