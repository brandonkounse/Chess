# frozen_string_literal: true

# board to interface with pieces
class Board
  attr_reader :squares

  def initialize
    @squares = Array.new(8) { Array.new(8) { nil } }
  end
end
