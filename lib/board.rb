# frozen_string_literal: true

require_relative 'modules/army'
require_relative 'modules/coordinates'

# board to interface with pieces
class Board
  include Army
  include Coordinates

  attr_reader :squares

  def initialize
    @squares = Array.new(8) { Array.new(8) { nil } }
    setup_board(:white, PIECE_ORDER)
    setup_board(:black, PIECE_ORDER)
  end

  def display
    squares.each_with_index do |row, i|
      row.each_with_index do |square, j|
        if (i + j).even?
          # Light background
          print "\e[48;5;186m #{square&.model || ' '} \e[0m"
        else
          # Dark background
          print "\e[48;5;101m #{square&.model || ' '} \e[0m"
        end
      end
      puts # To move to the next line after printing each row
    end
  end

  def move_piece(start, dest)
    piece = squares[start[X]][start[Y]]
    update_piece_state(piece) if piece.respond_to?(:mark_as_moved)
    update_squares(start, dest)
  end

  private

  # This section is for the arrangement of pieces on the board

  def setup_board(color, pieces)
    setup_major_pieces(color, pieces)
    setup_pawns(color)
  end

  def setup_major_pieces(color, pieces)
    top_row = 0
    bottom_row = 7

    if color == :black
      add_major_pieces(pieces, :black, top_row)
    else
      add_major_pieces(pieces, :white, bottom_row)
    end
  end

  def add_major_pieces(pieces, color, row)
    squares[row].map!.each_with_index { |_square, index| pieces[index].new(color) }
  end

  def setup_pawns(color)
    top_row = 1
    bottom_row = 6

    if color == :black
      squares[top_row].map! { Pawn.new(color) }
    else
      squares[bottom_row].map! { Pawn.new(color) }
    end
  end

  def update_piece_state(piece)
    piece.mark_as_moved
  end

  def update_squares(start, dest)
    squares[dest[X]][dest[Y]] = squares[start[X]][start[Y]]
    squares[start[X]][start[Y]] = nil
  end
end
