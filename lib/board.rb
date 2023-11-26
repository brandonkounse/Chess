# frozen_string_literal: true

require_relative 'army'
require 'pry-byebug'

# board to interface with pieces
class Board
  include Army

  X = 0 # x coordinate
  Y = 1 # y coordinate

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

  def move_piece(start, dest)
    return :invalid_move unless legal_move?(start, dest)

    squares[dest[X]][dest[Y]] = squares[start[X]][start[Y]]
    squares[start[X]][start[Y]] = nil
    :success
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
    top_row = 1
    bottom_row = 6

    if color == :black
      squares[top_row].map! { Army::PAWN.new(color) }
    else
      squares[bottom_row].map! { Army::PAWN.new(color) }
    end
  end

  # This section is for pieces making moves, their legality, and interfacing with piece classes

  def legal_move?(start, dest)
    valid_basic_move?(start, dest) && valid_capture_move?(start, dest)
  end

  def valid_basic_move?(start, dest)
    piece_can_move?(start, dest) && path_empty?(piece_path(start, dest))
  end

  def valid_capture_move?(start, dest)
    # binding.pry
    piece = squares[start[X]][start[Y]]
    if piece.is_a?(Pawn) && opponent_piece_at_destination?(start, dest)
      piece.can_capture?(start, dest)
    else
      square_empty?(dest) || opponent_piece_at_destination?(start, dest)
    end
  end

  def square_empty?(dest)
    squares[dest[X]][dest[Y]].nil?
  end

  def path_empty?(path)
    return true if path.nil? # Knights will move without a path

    path.all? { |x, y| squares[x][y].nil? }
  end

  def opponent_piece_at_destination?(start, dest)
    destination_piece = squares[dest[X]][dest[Y]]
    return false if destination_piece.nil?

    start_piece = squares[start[X]][start[Y]]
    start_piece.color != destination_piece.color
  end

  def piece_can_move?(start, dest)
    piece = squares[start[X]][start[Y]]
    piece&.can_move?(start, dest)
  end

  def piece_path(start, dest)
    piece = squares[start[X]][start[Y]]
    piece&.generate_path(start, dest)
  end
end
