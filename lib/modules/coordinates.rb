# frozen_string_literal: true

# constants to avoid magic numbers when working with grid for board
module Coordinates
  X = 0 # row coordinate
  Y = 1 # column coordinate

  def out_of_bounds(square)
    square > 7 || square.negative?
  end
end
