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
    # U+265D
    @model = if color == :black
               "\e[38;5;0m♝"
             else
               "\e[38;5;255m♝"
             end
  end
end
