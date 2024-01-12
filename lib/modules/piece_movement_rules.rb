# frozen_string_literal: true

require_relative 'army'
require_relative 'coordinates'

# Helper module for rules to move pieces on the board
module PieceMovementRules
  include Coordinates

  def can_move?(piece, start, dest)
    if piece.instance_of?(Pawn)
      pawn_can_move?(piece, start, dest)
    elsif piece.instance_of?(Knight)
      knight_can_move?(piece, start, dest)
    elsif piece.instance_of?(King)
      king_can_move?(piece, start, dest)
    else
      major_piece_can_move?(piece, start, dest)
    end
  end

  def path(piece, start, dest)
    if piece.instance_of?(Pawn)
      pawn_path(piece, start, dest)
    elsif piece.instance_of?(Knight)
      nil
    else
      major_piece_path(piece, start, dest)
    end
  end

  def pawn_can_capture?(piece, start, dest)
    return unless piece.instance_of?(Pawn)

    requested_movement = calculate_movement(start, dest)
    requested_movement == piece.movement[:forward_left] || requested_movement == piece.movement[:forward_right]
  end

  private

  def pawn_can_move?(pawn, start, dest)
    requested_movement = calculate_movement(start, dest)
    return false if requested_movement == pawn.movement[:forward_twice] && pawn.moved? == true

    pawn.movement.value?(requested_movement)
  end

  def knight_can_move?(knight, start, dest)
    requested_movement = calculate_movement(start, dest)

    knight.movement.any? { |movement| movement == requested_movement }
  end

  def king_can_move?(king, start, dest)
    requested_movement = calculate_movement(start, dest)
    king.movement.any? { |move| move == requested_movement }
  end

  def major_piece_can_move?(piece, start, dest)
    piece.movement.any? do |move_x, move_y|
      current_move = [start[X] + move_x, start[Y] + move_y]

      until current_move.any? { |square| out_of_bounds(square) }
        return true if current_move == dest

        current_move[X] += move_x
        current_move[Y] += move_y
      end
    end
  end

  def calculate_movement(start, dest)
    [dest[0] - start[0], dest[1] - start[1]]
  end

  def pawn_path(pawn, start, dest)
    requested_movement = calculate_movement(start, dest)
    return calculate_gap(pawn, start) if pawn.movement[:forward_twice] == requested_movement

    nil
  end

  def major_piece_path(piece, start, dest)
    piece.movement.each do |move_x, move_y|
      current_move = [start[X] + move_x, start[Y] + move_y]
      path = []
      until current_move.any? { |square| out_of_bounds(square) }
        return path if current_move == dest

        path << current_move.dup
        current_move[X] += move_x
        current_move[Y] += move_y
      end
    end
    nil
  end

  def calculate_gap(pawn, start)
    # will return the board square directly behind where the pawn's final destination is
    [[start[X] + pawn.movement[:forward_once][X], start[Y] + pawn.movement[:forward_once][Y]]]
  end
end
