require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
  end
end

if $PROGRAM_NAME == __FILE__
  puts "Play the brilliant computer!"
  cp1 = HumanPlayer.new()
  cp2S = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end