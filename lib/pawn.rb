# frozen_string_literal: true

# Pawn piece for chess board
class Pawn
  attr_reader :color

  def initialize(color = nil)
    @color = color
  end
end
