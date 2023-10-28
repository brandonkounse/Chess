# frozen_string_literal: true

# Queen piece for chess board
class Queen
  attr_reader :color, :model

  def initialize(color)
    @color = color
    set_model
  end

  private

  def set_model
    @model = if color == :black
               '♛' # U+265B
             else
               '♕' # U+2655
             end
  end
end
