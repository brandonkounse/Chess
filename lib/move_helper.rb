# frozen_string_literal: true

require_relative 'army'

# Helper module for move legality to interface with board
module MoveHelper
  X = 0 # x coordinate
  Y = 1 # y coordinate

  def self.can_move?(piece, start, dest)
    if piece.instance_of?(Pawn)
      pawn_can_move?(piece, start, dest)
    elsif piece.instance_of?(Knight)
      knight_can_move?(piece, start, dest)
    else
      major_piece_can_move?(piece, start, dest)
    end
  end

  # Specific movement patters that #can_move? calls

  def self.pawn_can_move?(pawn, start, dest)
    requested_movement = calculate_movement(start, dest)
    return false if requested_movement == pawn.movement[:forward_twice] && pawn.mark_as_moved

    pawn.movement.value?(requested_movement)
  end

  def self.knight_can_move?(knight, start, dest)
    requested_movement = calculate_movement(start, dest)

    knight.movement.any? { |movement| movement == requested_movement }
  end

  def self.major_piece_can_move?(piece, start, dest)
    piece.movement.any? do |move_x, move_y|
      current_move = [start[X] + move_x, start[Y] + move_y]

      until current_move.any? { |move| move > 7 || move.negative? }
        return true if current_move == dest

        current_move[X] += move_x
        current_move[Y] += move_y
      end
    end
  end

  def self.calculate_movement(starting_coordinates, destination_coordinates)
    [destination_coordinates[0] - starting_coordinates[0], destination_coordinates[1] - starting_coordinates[1]]
  end
end
