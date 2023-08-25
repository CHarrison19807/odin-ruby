class KnightsTravails
  attr_reader :position, :parent

  MOVE_DIRECTIONS = [[1, 2], [-2, -1], [-1, 2], [2, -1],
                     [1, -2], [-2, 1], [-1, -2], [2, 1]].freeze

  @@position_history = []
  

  def initialize(position, parent)
    @position = position
    @parent = parent
    @@position_history.push(position)
  end

  def children
    MOVE_DIRECTIONS.map { |move| [@position[0] + move[0], @position[1] + move[1]] }
                   .reject { |new_position| @@position_history.include?(new_position)  || !KnightsTravails.valid?(new_position) }
                   .map { |new_position| KnightsTravails.new(new_position, self) }
  end

  def self.valid?(position)
    position[0].between?(1, 8) && position[1].between?(1, 8)
  end
end

def display_parent(node, count)
  display_parent(node.parent, count + 1) unless node.parent.nil?
  puts "You made it in #{count} move(s)! Here's your path:" if node.parent.nil?
  p node.position
end

def knight_moves(start_position, end_position)
  queue = []
  current_node = KnightsTravails.new(start_position, nil)
  until current_node.position == end_position
    current_node.children.each { |child| queue.push(child) }
    current_node = queue.shift
  end
  display_parent(current_node, 0)
end

knight_moves([3, 3], [4, 3])
