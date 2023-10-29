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
          # White background, black foreground
          print "\e[38;5;0;48;5;255m #{square&.model || ' '} \e[0m"
        else
          # Black background, white foreground
          print "\e[38;5;255;48;5;0m #{square&.model || ' '} \e[0m"
        end
      end
      puts  # To move to the next line after printing each row
    end
  end

  def square_empty?(square)
    square.nil?
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
