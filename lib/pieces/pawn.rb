# frozen_string_literal: true

require_relative 'piece'

# Pawn piece for chess board
class Pawn < Piece
  attr_reader :color, :model, :movement

  def initialize(color)
    super(color)
    @model = assign_model_from_color('♟')
    @movement = {
      forward_once: [direction, 0],
      forward_twice: [2 * direction, 0],
      forward_left: [direction, -1],
      forward_right: [direction, 1]
    }
    @moved = false
  end

  def mark_as_moved
    @moved = true
  end

  def moved?
    @moved
  end

  private

  def direction
    color == :white ? -1 : 1
  end
end
