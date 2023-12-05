# frozen_string_literal: true

require_relative 'board'
require_relative 'modules/coordinates'
require_relative 'move_legality'

# class to handle game flow
class GameController
  attr_reader :board

  def initialize
    @board = Board.new
  end

  def make_move(start, dest)
    if MoveLegality.new(board.squares).legal_move?(start, dest)
      board.move_piece(start, dest)
    else
      puts 'invalid move'
    end
  end
end
