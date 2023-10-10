# frozen_string_literal: true

# Player class to interface with chess game
class Player
  attr_reader :color

  def initialize(color = nil)
    @color = color
  end
end
