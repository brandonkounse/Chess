# frozen_string_literal: true

# Rook piece for chess board
class Rook
  attr_reader :color, :model

  def initialize(color)
    @color = color
    set_model
  end

  private

  def set_model
    @model = if color == :black
               '♜' # U+265C
             else
               '♖' # U+2656
             end
  end
end
