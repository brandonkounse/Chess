# frozen_string_literal: true

# Pawn piece for chess board
class Pawn
  attr_reader :color, :model, :has_moved, :basic_movement, :attack_movement, :special_movement

  def initialize(color)
    @color = color
    @has_moved = false
    set_movements
    set_model
  end

  def can_move?(starting_coordinates, destination_coordinates)
    requested_movement = [destination_coordinates[0] - starting_coordinates[0],
                          destination_coordinates[1] - starting_coordinates[1]]
    basic_movement.include?(requested_movement) ||
      attack_movement.include?(requested_movement) ||
      special_movement.include?(requested_movement)
  end

  private

  def set_movements
    direction = color == :white ? 1 : -1
    @basic_movement = {
      forward_once: [direction, 0],
      forward_twice: [2 * direction, 0]
    }
    @attack_movement = {
      forward_left: [direction, -1],
      forward_right: [direction, 1]
    }
    @special_movement = {
      en_passant_left: [2 * direction, -1],
      en_passant_right: [2 * direction, 1]
    }
  end

  def set_model
    # U+265F
    @model = if color == :black
               "\e[38;5;0m♟"
             else
               "\e[38;5;255m♟"
             end
  end
end
