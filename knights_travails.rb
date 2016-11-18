require_relative 'nodes'
class KnightPathFinder

  DIRECTIONS = [
    [1,2],
    [1,-2],
    [-1,2],
    [-1,-2],
    [2,1],
    [-2,1],
    [2,-1],
    [-2,-1]
  ]

  def self.valid_moves(pos)
    row, col = pos
    positions = DIRECTIONS.map { |x, y| [row + x, col + y] }
    positions.select { |x, y| x.between?(0, 7) && y.between?(0, 7) }
  end

  def initialize(start_pos)
    @start_pos = start_pos
    @visited_positions = [start_pos]
  end


end
