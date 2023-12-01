# frozen_string_literal: true

require_relative 'pawn'
require_relative 'rook'
require_relative 'knight'
require_relative 'bishop'
require_relative 'queen'
require_relative 'king'

# module for creating sets of colored pieces
module Army
  PIECE_ORDER = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook].freeze
end
