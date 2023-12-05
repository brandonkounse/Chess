# frozen_string_literal: true

require_relative 'piece'

# King piece for chess board
class King < Piece
  attr_reader :color, :model, :movement

  def initialize(color)
    super(color)
    @model = assign_model_from_color('♚')
    @movement = [[1, 1], [1, -1], [-1, -1], [-1, 1], [1, 0], [-1, 0], [0, 1], [0, -1]]
  end
end
