# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/modules/piece_movement_rules'

describe PieceMovementRules do
  include PieceMovementRules

  describe '#can_move?' do
    context 'when piece is a pawn' do
      let(:pawn) { Pawn.new(:white) } 
      let(:start) { [[6, 1], [4, 0]] }
      let(:dest) { [[5, 1], [4, 1], [5, 0], [5, 2], [3, 1], [5, 0]] }

      context 'when valid movements' do
        it 'moves pawn 1 space forward and returns true' do
          expect(can_move?(pawn, start[0], dest[0])).to be true
        end
  
        it 'moves pawn 2 spaces forward and returns true' do
          expect(can_move?(pawn, start[0], dest[1])).to be true
        end
  
        it 'moves pawn 1 space diagonally left and returns true' do
          expect(can_move?(pawn, start[0], dest[2])).to be true
        end
  
        it 'moves pawn 1 space diagonally right and returns true' do
          expect(can_move?(pawn, start[0], dest[3])).to be true
        end
      end
      
      context 'when invalid movements' do
        it 'fails to move pawn 3 spaces out of range' do
          expect(can_move?(pawn, start[0], dest[4])).to be false
        end

        it 'fails to move pawn backwards' do
          expect(can_move?(pawn, start[1], dest[5])).to be false
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
