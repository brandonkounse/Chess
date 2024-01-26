# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/modules/piece_movement_rules'

describe PieceMovementRules do
  include PieceMovementRules

  describe '#can_move?' do
    context 'when piece is a pawn' do
      let(:pawn) { Pawn.new(:white) }        

      context 'when destination is empty and valid move' do
        let(:start) { [6, 0] }
        let(:dest) { [5, 0] }

        it 'calls #pawn_can_move? and returns true' do
          expect(can_move?(pawn, start, dest)).to be true
        end
      end

      context 'when destination is empty but invalid move' do
        let(:start) { [6, 0] }
        let(:dest) { [5, 1] }

        it 'calls #pawn_can_move? and returns false' do
          expect(can_move?(pawn, start, dest)).to be false
        end
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

    context 'when piece is a king' do
      let(:king) { King.new(:black) }
      let(:start) { [5, 3] }
      let(:dest) { [5, 4] }

      it 'calls #king_can_move? and returns true' do
        expect(king_can_move?(king, start, dest)).to be true
      end
    end
  end
end
