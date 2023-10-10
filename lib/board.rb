# frozen_string_literal: true

require_relative 'army'

# board to interface with pieces
class Board
  include Army

  attr_reader :squares, :white_pieces, :black_pieces

  def initialize
    @squares = Array.new(8) { Array.new(8) { nil } }
    @white_pieces = Army.create(:white)
    @black_pieces = Army.create(:black)
  end
end
