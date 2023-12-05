# frozen_string_literal: true

require_relative 'piece'

# Knight piece for chess board
class Knight < Piece
  attr_reader :color, :model, :movement

  def initialize(color)
    super(color)
    @model = assign_model_from_color('♞')
    @movement = [[2, 1], [2, -1], [-1, 2], [-1, -2], [1, 2], [1, -2], [-2, 1], [-2, -1]]
  end
end
