require_relative 'nodes'
class KnightPathFinder
  DIRECTIONS = [
    [ 1,  2],
    [ 1, -2],
    [-1,  2],
    [-1, -2],
    [ 2,  1],
    [-2,  1],
    [ 2, -1],
    [-2, -1]
  ]

  def self.valid_moves(pos)
    row, col = pos
    positions = DIRECTIONS.map { |x, y| [row + x, col + y] }
    positions.select { |x, y| x.between?(0, 7) && y.between?(0, 7) }
  end

  def initialize(start_pos)
    set_new_start(start_pos)
  end

  def set_new_start(pos)
    @start_pos = pos
    @visited_positions = [@start_pos]
    @tree = build_move_tree
  end

  def find_path(end_pos)
    end_node = @tree.dfs(end_pos)

    trace_path_back(end_node)
  end

  private

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
      new_positions = new_move_positions(current_node.value)
      new_positions.each do |pos|
        node = PolyTreeNode.new(pos)
        node.parent = current_node
        queue << node
      end
    end

    root
  end

  def trace_path_back(node)
    path = [node.value]

    until node.parent.nil?
      path.unshift(node.parent.value)
      node = node.parent
    end

    path
  end
end
