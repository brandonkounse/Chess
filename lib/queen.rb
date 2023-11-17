# frozen_string_literal: true

# Queen piece for chess board
class Queen < Piece
  attr_reader :color, :model

  def initialize(color)
    super()
    @color = color
    set_model
    set_movement
  end

  private

  def set_model
    # U+265B
    @model = if color == :black
               "\e[38;5;0m♛"
             else
               "\e[38;5;255m♛"
             end
  end

  def set_movement
    @movement = [[1, 1], [1, -1], [-1, -1], [-1, 1], [1, 0], [-1, 0], [0, 1], [0, -1]]
  end
end
