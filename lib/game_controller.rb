# frozen_string_literal: true

require_relative 'player'
require_relative 'board'
require_relative 'move_legality'
require_relative 'modules/coordinates'
require_relative 'modules/square_selection'

# class to handle game flow
class GameController
  include SquareSelection

  attr_reader :board, :player1, :player2

  def initialize
    @board = Board.new
    @player1 = Player.new(:white)
    @player2 = Player.new(:black)
  end

  def facilitate_turn(player)
    loop do
      start, dest = *turn(player)
      start = square_lookup(start)
      dest = square_lookup(dest)
      puts MoveLegality.new(board.squares).legal_move?(start, dest)
      if MoveLegality.new(board.squares).legal_move?(start, dest)
        make_move(start, dest)
        break
      end
    end
  end

  private

  def player_move(player)
    player.input
  end

  def turn(player)
    print "\n Please select piece to move: "
    start = player_move(player)
    print "\n Please select destination square: "
    dest = player_move(player)
    [start, dest]
  end

  def make_move(start, dest)
    board.move_piece(start, dest)
  end

  # def make_move(start, dest)
  #   board.move_piece(start, dest) if MoveLegality.new(board.squares).legal_move?(start, dest)
  # end

  def parse_move(move)
    move.scan(/[a-zA-Z]\d/)
  end

  def input_valid?(input)
    input.match?(/^[a-hA-H1-8]{4}$/)
  end
end
