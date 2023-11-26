# frozen_string_literal: true

require_relative 'piece'

# Pawn piece for chess board
class Pawn < Piece
  attr_reader :color, :model

  def initialize(color)
    super()
    @color = color
    set_movement
    set_model
  end

  # polymorphic override for pawn class to work with #can_move?
  def can_move?(starting_coordinates, destination_coordinates)
    requested_movement = calculate_movement(starting_coordinates, destination_coordinates)
    return false if requested_movement == @movement[:forward_twice] && moved?(starting_coordinates)

    @movement.value?(requested_movement)
  end

  def can_capture?(starting_coordinates, destination_coordinates)
    requested_movement = calculate_movement(starting_coordinates, destination_coordinates)

    requested_movement == @movement[:forward_left] || requested_movement == @movement[:forward_right]
  end

  def generate_path(starting_coordinates, destination_coordinates)
    requested_movement = calculate_movement(starting_coordinates, destination_coordinates)
    return calculate_gap(starting_coordinates) if @movement[:forward_twice] == requested_movement

    nil
  end

  def moved?(current_coordinates)
    initial_row = (color == :black ? 1 : 6)
    return true if current_coordinates[0] != initial_row

    false
  end

  private

  def set_movement
    @movement = {
      forward_once: [direction, 0],
      forward_twice: [2 * direction, 0],
      forward_left: [direction, -1],
      forward_right: [direction, 1]
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
    # will return the board square directly behind where the pawn's final destination is
    [[starting_coordinates[X] + @movement[:forward_once][X], starting_coordinates[Y] + @movement[:forward_once][Y]]]
  end
end
