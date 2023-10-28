# frozen_string_literal: true

# Knight piece for chess board
class Knight
  attr_reader :color, :model

  def initialize(color)
    @color = color
    set_model
  end

  private

  def set_model
    @model = if color == :black
               '♞' # U+265E
             else
               '♘' # U+2658
             end
  end
end
