# frozen_string_literal: true

# Pawn piece for chess board
class Pawn
  attr_reader :color, :model, :has_moved, :movement

  def initialize(color = nil)
    @color = color
    @has_moved = false
    @movement = {
      forward_left: [1, -1],
      forward_right: [1, 1],
      forward_once: [1, 0],
      forward_twice: [2, 0],
      en_passant_left: [2, -1],
      en_passant_right: [2, 1]
    }
    set_model
  end

  def move(coords)
    return unless movement.value?(coords)

    @has_moved = true
    coords
  end

  private

  def set_model
    # U+265F
    @model = if color == :black
               "\e[38;5;0m♟"
             else
               "\e[38;5;255m♟"
             end
  end
end
