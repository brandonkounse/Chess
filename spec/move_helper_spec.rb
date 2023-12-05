# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/modules/move_helper'

describe MoveHelper do
  include MoveHelper

  describe '#can_move?' do
    context 'when piece is a pawn' do
      let(:pawn) { Pawn.new(:white) }
      let(:start) { [6, 0] }
      let(:dest) { [5, 0] }

      it 'calls #pawn_can_move? and returns true' do
        expect(can_move?(pawn, start, dest)).to be true
      end
    end

    context 'when piece is a knight' do
      let(:knight) { Knight.new(:black) }
      let(:start) { [0, 1] }
      let(:dest) { [2, 2] }

      it 'calls #knight_can_move? and returns true' do
        expect(knight_can_move?(knight, start, dest)).to be true
      end
    end

    context 'when piece is a bishop' do
      let(:bishop) { Bishop.new(:white) }
      let(:start) { [7, 5] }
      let(:dest) { [5, 3] }

      it 'calls #major_piece_can_move? and returns true' do
        expect(major_piece_can_move?(bishop, start, dest)).to be true
      end
    end

    context 'when piece is a rook' do
      let(:rook) { Rook.new(:black) }
      let(:start) { [0, 7] }
      let(:dest) { [4, 7] }

      it 'calls #major_piece_can_move? and returns true' do
        expect(major_piece_can_move?(rook, start, dest)).to be true
      end
    end

    context 'when piece is a queen' do
      let(:queen) { Queen.new(:white) }
      let(:start) { [7, 3] }
      let(:dest) { [4, 6] }

      it 'calls #major_piece_can_move? and returns true' do
        expect(major_piece_can_move?(queen, start, dest)).to be true
      end
    end
  end
end
