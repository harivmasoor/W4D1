require_relative 'tic_tac_toe'
require 'byebug'

class TicTacToeNode
    def initialize(board, next_mover_mark, prev_move_pos = nil)
        @board = board
        @next_mover_mark = next_mover_mark
        @prev_move_pos = prev_move_pos
    end

    attr_reader :board, :prev_move_pos, :next_mover_mark 

    def children
        nodes = []

        (0..2).each do |row|
            (0..2).each do |col|
                pos = [row, col]

                unless board[pos]
                    new_board = board.dup
                    new_board[pos] = @next_mover_mark
                    new_next_mover_mark = @next_mover_mark == :x ? :o : :x
                    nodes << TicTacToeNode.new(new_board, new_next_mover_mark, pos)
                end
            end
        end

        nodes
    end

    def losing_node?(evaluator)
        if board.over?
            return !(@board.winner == evaluator || @board.winner.nil?)
        end

        if self.next_mover_mark == evaluator # evaluator's turn
            self.children.all? { |child| child.losing_node?(evaluator) }
        else # opponent's turn
            self.children.any? { |child| child.losing_node?(evaluator) }
        end
    end

    def winning_node?(evaluator)
        if @board.over?
            return @board.winner == evaluator
        end

        if self.next_mover_mark == evaluator
            self.children.any? { |child| child.winning_node?(evaluator) }
        else
            self.children.all? { |child| child.winning_node?(evaluator) }
        end
    end
end