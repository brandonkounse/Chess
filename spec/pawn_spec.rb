# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/pawn'

describe Pawn do
  let(:white) { 'white' }
  let(:black) { 'black' }

  describe 'initialize' do
    context 'when a new pawn is created' do
      subject(:new_pawn) { Pawn.new(white) }

      it 'assigns color to the piece' do
        color = white
        expect(new_pawn.color).to eq(color)
      end

      it 'assigns has_moved to false' do
        expect(new_pawn.has_moved).to be false
      end
    end
  end

  describe 'move' do
    subject(:new_pawn) { Pawn.new(black) }

    context 'when the pawn moves' do
      it 'changes has_moved to true' do
        new_pawn.move([1, 1])
        expect(new_pawn.has_moved).to be true
      end

      it 'returns coords in en_passant_right' do
        coords = [2, 1]
        expect(new_pawn.move(coords)).to eq(coords)
      end

      it 'returns corrds in forward_once' do
        coords = [1, 1]
        expect(new_pawn.move(coords)).to eq(coords)
      end

      it 'returns corrds in forward_left' do
        coords = [1, -1]
        expect(new_pawn.move(coords)).to eq(coords)
      end

      it 'returns nil if invalid coords' do
        coords = [0, 14]
        expect(new_pawn.move(coords)).to be nil
      end
    end
  end
end
