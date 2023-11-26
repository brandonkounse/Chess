# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/bishop'

describe Bishop do
  describe 'initialize' do
    context 'when a new bishop is created' do
      subject(:new_bishop) { Bishop.new(:white) }

      it 'assigns color to the piece' do
        expect(new_bishop.color).to eq(:white)
      end
    end
  end

  describe 'can_move?' do
    subject(:bishop) { Bishop.new(:black) }

    context 'when given valid path coordinates' do
      let(:start) { [[7, 2], [7, 5]] }
      let(:destination) { [[4, 5], [4, 2]] }

      it 'returns true with ([7, 2], [4, 5])' do
        expect(bishop.can_move?(start[0], destination[0])).to be true
      end

      it 'returns true with ([7, 5], [4, 2])' do
        expect(bishop.can_move?(start[1], destination[1])).to be true
      end
    end

    context 'when given invalid path coordinates' do
      let(:start) { [[7, 2], [7, 5]] }
      let(:destination) { [[4, 2], [4, 7]] }

      it 'returns false with ([7, 2], [4, 2])' do
        expect(bishop.can_move?(start[0], destination[0])).to be false
      end

      it 'returns false with ([7, 5], [4, 7])' do
        expect(bishop.can_move?(start[1], destination[1])).to be false
      end
    end
  end

  describe 'generate_path' do
    subject(:bishop) { Bishop.new(:white) }

    context 'when given a valid path' do
      let(:start) { [[7, 2], [7, 5]] }
      let(:destination) { [[4, 5], [4, 2]] }

      it 'returns path array for ([7, 2], [4, 5])' do
        path = [[6, 3], [5, 4]]
        expect(bishop.generate_path(start[0], destination[0])).to eq(path)
      end

      it 'returns path array for ([7, 5], [4, 2])' do
        path = [[6, 4], [5, 3]]
        expect(bishop.generate_path(start[1], destination[1])).to eq(path)
      end
    end

    context 'when given an invalid path' do
      let(:start) { [[7, 2], [7, 5]] }
      let(:destination) { [[4, 2], [4, 7]] }

      it 'returns nil with ([7, 2], [4, 2])' do
        expect(bishop.generate_path(start[0], destination[0])).to be_nil
      end

      it 'returns nil with ([7, 5], [4, 7])' do
        expect(bishop.generate_path(start[1], destination[1])).to be_nil
      end
    end
  end
end
