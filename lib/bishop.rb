# frozen_string_literal: true

require_relative 'piece'

# Bishop piece for chess board
class Bishop < Piece
  attr_reader :color, :model, :movement

  def initialize(color)
    super(color)
    @model = assign_model_from_color('♝')
    @movement = @movement = [[1, 1], [1, -1], [-1, -1], [-1, 1]]
  end
end
