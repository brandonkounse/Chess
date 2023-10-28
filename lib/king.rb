# frozen_string_literal: true

# King piece for chess board
class King
  attr_reader :color, :model

  def initialize(color)
    @color = color
    set_model
  end

  private

  def set_model
    @model = if color == :black
               '♚' # U+265A
             else
               '♔' # U+2654
             end
  end
end
