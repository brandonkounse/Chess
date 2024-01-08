# frozen_string_literal: true

require_relative 'player'
require_relative 'board'
require_relative 'move_legality'
require_relative 'modules/coordinates'
require_relative 'modules/square_selection'
require 'pry-byebug'

# class to handle game flow
class GameController
  include SquareSelection

  attr_reader :board, :player_white, :player_black

  def initialize
    @board = Board.new
    @player_white = Player.new(:white)
    @player_black = Player.new(:black)
  end

  def play
    loop do
      facilitate_turn(player_white)
      break if over?

      board.display

      facilitate_turn(player_black)
      break if over?

      board.display
    end
  end

  private

  def over?; end

  def save; end

  def quit; end

  def prompt_for_move(player)
    print "\nPlease select a piece to move: "
    player.input
  end

  def get_player_move(player)
    move = ''
    loop do
      move = prompt_for_move(player)
      return parse_move(move) if input_valid?(move)

      puts "Invalid move format. Please enter a move like 'a2a4'."
    end
  end

  def facilitate_turn(player)
    loop do
      start, dest = *get_player_move(player)
      start = square_lookup(start)
      dest = square_lookup(dest)
      if legal_move?(start, dest, MoveLegality)
        make_move(start, dest)
        break
      end
    end
  end

  def legal_move?(start, dest, legal_class)
    legal_class.new(board.squares).legal_move?(start, dest)
  rescue NoMethodError
    puts 'starting square must have a piece to move!'
    false
  end

  def make_move(start, dest)
    board.move_piece(start, dest)
  end

  def parse_move(move)
    [move[0, 2], move[2, 2]]
  end

  def input_valid?(input)
    input.match?(/^[a-hA-H1-8]{4}$/)
  end
end
