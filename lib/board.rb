# frozen_string_literal: true

require_relative 'army'

# board to interface with pieces
class Board
  include Army

  attr_reader :squares

  def initialize
    @squares = Array.new(8) { Array.new(8) { nil } }
    setup_board(:white, Army::PIECE_ORDER)
    setup_board(:black, Army::PIECE_ORDER)
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

  def move_piece(starting_square, destination_square)
    return :invalid_move unless legal_move?(starting_square, destination_square)

    squares[destination_square[0]][destination_square[1]] = squares[starting_square[0]][starting_square[1]]
    squares[starting_square[0]][starting_square[1]] = nil
    :success
  end

  private

  def setup_board(color, pieces)
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

  def legal_move?(starting_square, destination_square)
    return false unless piece_can_move?(starting_square, destination_square) && path_empty?(piece_path(starting_square, destination_square))

    square_empty?(destination_square) || opponent_piece_at_destination?(starting_square, destination_square)
  end

  def square_empty?(destination_square)
    squares[destination_square[0]][destination_square[1]].nil?
  end

  def path_empty?(path)
    return true if path.nil? # Knight's will move without a path

    path.all? { |x, y| squares[x][y].nil? }
  end

  def opponent_piece_at_destination?(starting_square, destination_square)
    piece_have_opposing_color?(starting_square, destination_square)
  end

  def piece_have_opposing_color?(starting_square, destination_square)
    squares[starting_square[0]][starting_square[1]].color != squares[destination_square[0]][destination_square[1]].color
  end

  def piece_can_move?(starting_square, destination_square)
    piece = squares[starting_square[0]][starting_square[1]]
    piece&.can_move?(starting_square, destination_square)
  end

  def piece_path(starting_square, destination_square)
    piece = squares[starting_square[0]][starting_square[1]]
    piece&.generate_path(starting_square, destination_square)
  end
end
