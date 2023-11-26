# frozen_string_literal: true

# Piece superclass for chess pieces
class Piece
  X = 0 # x coordinate
  Y = 1 # y coordinate

  def initialize; end

  def can_move?(starting_coordinates, destination_coordinates)
    requested_movement = calculate_movement(starting_coordinates, destination_coordinates)

    @movement.any? { |movement| movement == requested_movement }
  end

  def generate_path(_starting_coordinates, _destination_coordinates)
    nil
  end

  def calculate_movement(starting_coordinates, destination_coordinates)
    [destination_coordinates[0] - starting_coordinates[0], destination_coordinates[1] - starting_coordinates[1]]
  end
end
