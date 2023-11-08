# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/bishop'

describe Bishop do
  let(:white) { 'white' }
  let(:black) { 'black' }

  describe 'initialize' do
    context 'when a new bishop is created' do
      subject(:new_bishop) { Bishop.new(white) }

      it 'assigns color to the piece' do
        color = white
        expect(new_bishop.color).to eq(color)
      end
    end
  end

  describe 'can_move?' do
    subject(:bishop) { Bishop.new(black) }

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
end
