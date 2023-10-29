# frozen_string_literal: true

require_relative 'army'

# board to interface with pieces
class Board
  include Army

  attr_reader :squares

  def initialize
    @squares = Array.new(8) { Array.new(8) { nil } }
    setup_pieces(:white, Army::PIECE_ORDER)
    setup_pieces(:black, Army::PIECE_ORDER)
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
      puts  # To move to the next line after printing each row
    end
  end

  def square_empty?(square)
    square.nil?
  end

  def move_piece(start, destination)
    squares[destination[0]][destination[1]] = squares[start[0]][start[1]]
    squares[start[0]][start[1]] = nil
  end

  private

  def setup_pieces(color, pieces)
    setup_major_pieces(color, pieces)
    setup_pawns(color)
  end

  def setup_major_pieces(color, pieces)
    top_row = 0
    bottom_row = 7

    if color == :black
      squares[top_row].map!.each_with_index do |_square, index|
        pieces[index].new(color)
      end
    else
      squares[bottom_row].map!.each_with_index do |_squre, index|
        pieces[index].new(color)
      end
    end
  end

  def setup_pawns(color)
    black_pawn_row = 1
    white_pawn_row = 6

    if color == :black
      squares[black_pawn_row].map! { Army::PAWN.new(color) }
    else
      squares[white_pawn_row].map! { Army::PAWN.new(color) }
    end
  end
end
