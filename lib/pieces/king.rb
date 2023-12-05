# frozen_string_literal: true

require_relative 'piece'

# King piece for chess board
class King < Piece
  attr_reader :color, :model

  def initialize(color)
    super(color)
    @model = assign_model_from_color('♚')
  end
end
