class Table
  attr_reader :x, :y

  def initialize(x, y)
    @x = x - 1
    @y = y - 1
  end

  def place_exist?(x, y)
    x && y && x.between?(0, @x) && y.between?(0, @y)
  end
end
