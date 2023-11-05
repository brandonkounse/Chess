# frozen_string_literal: true

# Piece superclass for chess pieces
class Piece
  def initialize
    raise NotImplementedError, 'Subclasses must define @movement.'
  end

  def can_move?(starting_coordinates, destination_coordinates)
    requested_movement = [starting_coordinates[0] - destination_coordinates[0],
                          starting_coordinates[1] - destination_coordinates[1]]

    @movement.any? { |movement| movement == requested_movement }
  end
end
