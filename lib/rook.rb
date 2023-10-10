# frozen_string_literal: true

# Rook piece for chess board
class Rook
  attr_reader :color

  def initialize(color = nil)
    @color = color
  end
end
