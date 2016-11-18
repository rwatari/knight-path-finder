class PolyTreeNode
  attr_reader :value, :parent, :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
    old_parent = @parent
    old_parent.children.delete(self) if old_parent

    @parent = node
    node.children << self if node
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise 'Not child' unless children.include?(child_node)
    child_node.parent = nil
  end

  def dfs(target)
    return self if value == target

    children.each do |child|
      result = child.dfs(target)
      return result if result
    end

    nil
  end

  def bfs(target)
    queue = [self]

    until queue.empty?
      current = queue.shift
      return current if current.value == target

      current.children.each { |child| queue << child }
    end

    nil
  end
end
