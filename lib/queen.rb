# frozen_string_literal: true

# Queen piece for chess board
class Queen
  attr_reader :color

  def initialize(color = nil)
    @color = color
  end
end
