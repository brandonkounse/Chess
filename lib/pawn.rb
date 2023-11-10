# frozen_string_literal: true

require_relative 'piece'

# Pawn piece for chess board
class Pawn < Piece
  attr_reader :color, :model, :has_moved

  def initialize(color)
    super()
    @color = color
    @has_moved = false
    set_movement
    set_model
  end

  # polymorphic override for pawn class to work with #can_move?
  def can_move?(starting_coordinates, destination_coordinates)
    requested_movement = calculate_movement(starting_coordinates, destination_coordinates)
    @movement.value?(requested_movement)
  end

  def generate_path(starting_coordinates, destination_coordinates)
    requested_movement = calculate_movement(starting_coordinates, destination_coordinates)
    return calculate_gap(starting_coordinates) if @movement[:forward_twice] == requested_movement

    nil
  end

  def update_moved_status(coordinates)
    @has_moved = true if (color == :black && coordinates[0] != 1) || (color == :white && coordinates[0] != 6)

    @has_moved
  end

  private

  def set_movement
    @movement = {
      forward_once: [direction, 0],
      forward_twice: [2 * direction, 0],
      forward_left: [direction, -1],
      forward_right: [direction, 1],
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

  def direction
    color == :white ? -1 : 1
  end

  def calculate_gap(starting_coordinates)
    [[starting_coordinates[0] + @movement[:forward_once][0], starting_coordinates[1] + @movement[:forward_once][1]]]
  end
end
