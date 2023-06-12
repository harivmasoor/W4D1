require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
    def move(game, mark)
        node = TicTacToeNode.new(game.board, mark)
        node.children.each do |child|
            if child.winning_node?(mark)
                return child.prev_move_pos
            end
        end

        node.children.each do |child|
            unless child.losing_node?(mark)
                return child.prev_move_pos
            end
        end
        
        raise "you are a awesome person, have a great day!"
    end
end

if $PROGRAM_NAME == __FILE__
    puts "Play the brilliant computer!"
    cp1 = HumanPlayer.new()
    cp2 = SuperComputerPlayer.new

    TicTacToe.new(cp1, cp2).run
end