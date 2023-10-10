# frozen_string_literal: true

require_relative 'pawn'
require_relative 'rook'
require_relative 'knight'
require_relative 'bishop'
require_relative 'queen'
require_relative 'king'

# module for creating sets of colored pieces
module Army
  def self.create(color)
    army = []
    8.times { army << Pawn.new(color) }
    2.times { army << Rook.new(color) }
    2.times { army << Knight.new(color) }
    2.times { army << Bishop.new(color) }
    army << Queen.new(color)
    army << King.new(color)
    army
  end
end
