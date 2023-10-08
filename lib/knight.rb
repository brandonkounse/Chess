# frozen_string_literal: true

# Knight piece for chess board
class Knight
  attr_reader :color

  def initialize(color = nil)
    @color = color
  end
end
