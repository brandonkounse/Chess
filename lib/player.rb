# frozen_string_literal: true

# Player class to interface with chess game
class Player
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def input
    gets.chomp
  end
end
