# frozen_string_literal: true

require_relative 'piece'

# Knight piece for chess board
class Knight < Piece
  attr_reader :color, :model

  def initialize(color)
    @color = color
    set_model
    set_movement
  end

  private

  def set_movement
    @movement = [[2, 1], [2, -1], [-1, 2], [-1, -2], [1, 2], [1, -2], [-2, 1], [-2, -1]]
  end

  def set_model
    # U+265E
    @model = if color == :black
               "\e[38;5;0m♞"
             else
               "\e[38;5;255m♞"
             end
  end
end
