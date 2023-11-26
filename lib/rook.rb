# frozen_string_literal: true

require_relative 'piece'

# Rook piece for chess board
class Rook < Piece
  attr_reader :color, :model

  def initialize(color)
    @color = color
    set_movement
    set_model
  end

  def can_move?(starting_coordinates, destination_coordinates)
    @movement.any? do |move_x, move_y|
      current_move = [starting_coordinates[0] + move_x, starting_coordinates[1] + move_y]

      until current_move.any? { |move| move > 7 || move.negative? }
        return true if current_move == destination_coordinates

        current_move[X] += move_x
        current_move[Y] += move_y
      end
    end
  end

  def generate_path(starting_coordinates, destination_coordinates)
    @movement.each do |move_x, move_y|
      current_move = [starting_coordinates[X] + move_x, starting_coordinates[Y] + move_y]
      path = []
      until current_move.any? { |move| move > 7 || move.negative? }
        return path if current_move == destination_coordinates

        path << current_move.dup
        current_move[X] += move_x
        current_move[Y] += move_y
      end
    end
    nil
  end

  private

  def set_movement
    @movement = [[1, 0], [-1, 0], [0, -1], [0, 1]]
  end

  def set_model
    # U+265C
    @model = if color == :black
               "\e[38;5;0m♜"
             else
               "\e[38;5;255m♜"
             end
  end
end
