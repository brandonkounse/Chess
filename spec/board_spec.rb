# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/board'

describe Board do
  describe 'initialize' do
    context 'when a new board is created' do
      subject(:new_board) { Board.new }

      it 'assigns 2D array of nil values to squares' do
        max_squares = 64
        nil_count = 0
        new_board.squares.each { |square| nil_count += square.count(nil) }
        expect(nil_count).to eq(max_squares)
      end
    end
  end
end
