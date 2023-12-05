# frozen_string_literal: true

# Piece superclass for chess pieces
class Piece
  def initialize(color)
    @color = color
  end

  private

  def assign_model_from_color(model)
    if @color == :black
      "\e[38;5;0m#{model}"
    else
      "\e[38;5;255m#{model}"
    end
  end
end
