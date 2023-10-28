# frozen_string_literal: true

# Bishop piece for chess board
class Bishop
  attr_reader :color, :model

  def initialize(color)
    @color = color
    set_model
  end

  private

  def set_model
    @model = if color == :black
               '♝' # U+265D
             else
               '♗' # U+2657
             end
  end
end
