# frozen_string_literal: true

require_relative '../pieces/pawn'
require_relative '../pieces/rook'
require_relative '../pieces/knight'
require_relative '../pieces/bishop'
require_relative '../pieces/queen'
require_relative '../pieces/king'

# module for creating sets of colored pieces
module Army
  PIECE_ORDER = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook].freeze
end
