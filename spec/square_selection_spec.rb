# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/modules/square_selection'

describe SquareSelection do
  include SquareSelection

  describe '#square_lookup' do
    context 'when given valid squares' do
      it 'returns [4, 3] for D4' do
        expect(square_lookup('D4')).to eq([4, 3])
      end

      it 'returns [0, 7] for H8' do
        expect(square_lookup('H8')).to eq([0, 7])
      end

      it 'returns [6, 3] for d2' do
        expect(square_lookup('d2')).to eq([6, 3])
      end

      it 'returns [3, 6] for g5' do
        expect(square_lookup('g5')).to eq([3, 6])
      end
    end

    context 'when given invalid squares' do
      it 'returns nil for i7' do
        expect(square_lookup('i7')).to be nil
      end

      it 'returns nil for 12345' do
        expect(square_lookup('12345')).to be nil
      end

      it 'returns nil for 5g' do
        expect(square_lookup('5g')).to be nil
      end

      it 'returns nil for a-1' do
        expect(square_lookup('a-1')).to be nil
      end

      it 'returns nil for a 1' do
        expect(square_lookup('a 1')).to be nil
      end
    end
  end
end
