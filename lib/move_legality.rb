# frozen_string_literal: true

require_relative 'move_helper'
require_relative 'coordinates'

# Class for determining the legality of moves
class MoveLegality
  include MoveHelper
  include Coordinates

  def initialize(squares)
    @squares = squares
  end

  def legal_move?(start, dest)
    valid_basic_move?(start, dest) && valid_capture_move?(start, dest)
  end

  private

  attr_reader :squares

  def valid_basic_move?(start, dest)
    piece_can_move?(start, dest) && path_empty?(piece_path(start, dest))
  end

  def valid_capture_move?(start, dest)
    piece = squares[start[X]][start[Y]]
    if piece.is_a?(Pawn) && opponent_piece_at_destination?(start, dest)
      pawn_can_capture?(piece, start, dest)
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
    can_move?(piece, start, dest)
  end

  def piece_path(start, dest)
    piece = squares[start[X]][start[Y]]
    path(piece, start, dest)
  end
end
