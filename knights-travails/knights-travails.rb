require_relative "../poly-tree-node/lib/tree_node.rb"
require "byebug"

class KnightPathFinder
    $move_directions = [[-1, -2], [-2, -1], [1, -2], [2, -1], [1, 2], [2, 1], [-2, 1], [-1, 2]]
    
    def initialize(start_pos)
        @start_pos = start_pos
        @considered_positions = [start_pos]
        @root_node = nil
        build_move_tree(start_pos)
    end
    
    attr_reader :considered_positions
    attr_accessor :root_node

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
        @root_node = PolyTreeNode.new(start_pos)
        q = [root_node]
        
        until q.empty?
            current = q.shift
            valid_moves_array = new_move_positions(current.value)

            valid_moves_array.each do |valid_move|
                valid_move_node = PolyTreeNode.new(valid_move)
                current.add_child(valid_move_node)
                q.push(valid_move_node)
            end
        end
    end

    def find_path(end_pos)
        end_node = root_node.dfs(end_pos)
        trace_path_back(end_node).reverse.map(&:value)
    end

    def trace_path_back(end_node)
        nodes = []
        current_node = end_node

        until current_node.nil?
            nodes << current_node
            current_node = current_node.parent
        end

        nodes
    end
end

kpf = KnightPathFinder.new([0, 0])
p kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
p kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]
