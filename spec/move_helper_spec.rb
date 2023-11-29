# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/move_helper'

describe MoveHelper do
  describe '#self.can_move?' do
    context 'when piece is a pawn' do
      let(:pawn) { Pawn.new(:white) }
      let(:start) { [6, 0] }
      let(:dest) { [5, 0] }

      it 'calls #pawn_can_move? and returns true' do
        expect(MoveHelper.can_move?(pawn, start, dest)).to be true
      end
    end
  end
end
