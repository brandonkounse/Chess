# frozen_string_literal: true

# King piece for chess board
class King
  attr_reader :color

  def initialize(color = nil)
    @color = color
  end
end
