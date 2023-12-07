# frozen_string_literal: true

require_relative 'board'
require_relative 'move_legality'
require_relative 'modules/coordinates'
require_relative 'modules/square_selection'

# class to handle game flow
class GameController
  include SquareSelection

  attr_reader :board

  def initialize
    @board = Board.new
  end

  private

  def make_move(start, dest)
    board.move_piece(start, dest) if MoveLegality.new(board.squares).legal_move?(start, dest)
  end

  def parse_move(move)
    move.scan(/[a-zA-Z]\d/)
  end

  def input_valid?(input)
    input.match?(/^[a-hA-H1-8]{4}$/)
  end
end
