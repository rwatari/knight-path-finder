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

  attr_reader :tree
  def initialize(start_pos)
    @start_pos = start_pos
    @visited_positions = [start_pos]
    @tree = build_move_tree
  end

  def new_move_positions(pos)
    moves = self.class.valid_moves(pos)
    moves.reject! { |move| @visited_positions.include?(move) }
    @visited_positions += moves

    moves
  end

  def build_move_tree
    root = PolyTreeNode.new(@start_pos)
    queue = [root]

    until queue.empty?
      current_node = queue.shift
      moves = new_move_positions(current_node.value)
      moves.each do |pos|
        node = PolyTreeNode.new(pos)
        node.parent = current_node
        queue << node
      end
    end

    root
  end
end
