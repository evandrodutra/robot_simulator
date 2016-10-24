class CommandParser
  def parse(cmd)
    case cmd.chomp
    when /^PLACE\s(\d+,){2}(NORTH|SOUTH|EAST|WEST)$/i
      x, y, f = cmd.split(/[\s\,]/)[1..3]
      { type: :place, x: x.to_i, y: y.to_i, f: f.downcase.to_sym }
    when /^MOVE$/i
      { type: :move }
    when /^LEFT$/i
      { type: :turn, direction: :left }
    when /^RIGHT$/i
      { type: :turn, direction: :right }
    when /^REPORT$/i
      { type: :report }
    end
  end

  def load(lines)
    return [] unless lines.is_a?(Array)

    lines.map do |line|
      parse(line)
    end.compact
  end
end
