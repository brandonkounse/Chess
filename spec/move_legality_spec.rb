# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/move_legality'
require_relative '../lib/board'

describe MoveLegality do
  describe '#legal_move?' do
    context 'when moving a pawn' do
      let(:white_pawn) { Pawn.new(:white) }
      let(:black_pawn) { Pawn.new(:black) }
      let(:board) { Board.new }
      let(:start) { [6, 3] }
      let(:dest) { [5, 2] }

      it 'white pawn captures black pawn d4c3' do
        board[5][2] = black_pawn
        expect(MoveLegality.new(board)).legal_move?(start, dest).to be true
      end
    end
  end
end
