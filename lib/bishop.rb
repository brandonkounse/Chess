# frozen_string_literal: true

require_relative 'piece'
require 'pry-byebug'

# Bishop piece for chess board
class Bishop < Piece
  attr_reader :color, :model

  def initialize(color)
    @color = color
    set_model
    set_movement
  end

  def can_move?(starting_coordinates, destination_coordinates)
    @movement.any? do |move_x, move_y|
      current_move = [starting_coordinates[0], starting_coordinates[1]]

      until current_move.any? { |move| move > 7 || move.negative? }
        return true if current_move == destination_coordinates

        current_move[0] += move_x
        current_move[1] += move_y
      end
    end
  end

  private

  def set_movement
    @movement = [[1, 1], [1, -1], [-1, -1], [-1, 1]]
  end

  def set_model
    # U+265D
    @model = if color == :black
               "\e[38;5;0m♝"
             else
               "\e[38;5;255m♝"
             end
  end
end
