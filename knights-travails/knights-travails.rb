require_relative "../poly-tree-node/lib/tree_node.rb"
require "byebug"

class KnightPathFinder
    $move_directions = [[-1, -2], [-2, -1], [1, -2], [2, -1], [1, 2], [2, 1], [-2, 1], [-1, 2]]
    
    def initialize(start_pos)
        @start_pos = start_pos
        @considered_positions = [start_pos]
        self.build_move_tree(start_pos)
    end
    
    attr_reader :considered_positions

    def self.valid_moves(pos)
        valid_moves_array = []
        $move_directions.each do |move_direction|
            new_row = pos[0] + move_direction[0]
            new_col = pos[1] + move_direction[1]
            valid_moves_array << [new_row, new_col] if (0..7).include?(new_row) && (0..7).include?(new_col)
        end

        valid_moves_array
    end
   
    def new_move_positions(pos)
        valid_moves_array = KnightPathFinder.valid_moves(pos)
        valid_moves_array.select! { |valid_move| !@considered_positions.include?(valid_move) }
        valid_moves_array.each { |valid_move| @considered_positions << valid_move }
        valid_moves_array
    end

    def build_move_tree(start_pos)
        root_node = PolyTreeNode.new(start_pos)
        q = [root_node]
        until q.empty?
            # debugger
            current = q.shift
            valid_moves_array = new_move_positions(current.value)

            valid_moves_array.each do |valid_move|
                valid_move_node = PolyTreeNode.new(valid_move)
                root_node.add_child(valid_move_node)
                q.push(valid_move_node)
            end
        end
    end

    def find_path(end_pos)
    
    end
end

knight_path = KnightPathFinder.new([0, 0])
p knight_path.build_move_tree([0,0])
p knight_path.considered_positions.length

