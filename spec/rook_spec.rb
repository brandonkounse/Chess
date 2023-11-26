# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/rook'

describe Rook do
  describe 'initialize' do
    context 'when a new rook is created' do
      subject(:new_rook) { Rook.new(:white) }

      it 'assigns color to the piece' do
        expect(new_rook.color).to eq(:white)
      end
    end
  end

  describe 'can_move?' do
    subject(:rook) { Rook.new(:white) }

    context 'when given valid path coordinates' do
      let(:start) { [[7, 0], [7, 7]] }
      let(:destination) { [[4, 0], [4, 7]] }

      it 'returns true with ([7, 0], [4, 0])' do
        expect(rook.can_move?(start[0], destination[0])).to be true
      end

      it 'returns true with ([7, 7], [4, 7])' do
        expect(rook.can_move?(start[1], destination[1])).to be true
      end
    end

    context 'when given invalid path coordinates' do
      let(:start) { [[7, 0], [7, 7]] }
      let(:destination) { [[4, 2], [4, 6]] }

      it 'returns false with ([7, 0], [4, 2])' do
        expect(rook.can_move?(start[0], destination[0])).to be false
      end

      it 'returns false with ([7, 7], [4, 6])' do
        expect(rook.can_move?(start[1], destination[1])).to be false
      end
    end
  end

  describe 'generate_path' do
    subject(:rook) { Rook.new(:black) }

    context 'when given a valid path' do
      let(:start) { [[0, 0], [0, 7]] }
      let(:destination) { [[4, 0], [4, 7]] }

      it 'returns path array for ([0, 0], [4, 0])' do
        path = [[1, 0], [2, 0], [3, 0]]
        expect(rook.generate_path(start[0], destination[0])).to eq(path)
      end

      it 'returns path array for ([0, 7], [4, 7])' do
        path = [[1, 7], [2, 7], [3, 7]]
        expect(rook.generate_path(start[1], destination[1])).to eq(path)
      end
    end

    context 'when given an invalid path' do
      let(:start) { [[0, 0], [0, 7]] }
      let(:destination) { [[4, 2], [4, 5]] }

      it 'returns nil with ([0, 0], [4, 2])' do
        expect(rook.generate_path(start[0], destination[0])).to be_nil
      end

      it 'returns nil with ([0, 7], [4, 5])' do
        expect(rook.generate_path(start[1], destination[1])).to be_nil
      end
    end
  end
end
