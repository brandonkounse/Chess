# frozen_string_literal: true

# Bishop piece for chess board
class Bishop
  attr_reader :color

  def initialize(color = nil)
    @color = color
  end
end
