# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/board'
require 'pry-byebug'

describe Board do
  describe 'initialize' do
    subject(:new_board) { Board.new }

    context 'when a new board is created' do
      it 'creates 64 total squares' do
        max_squares = 64
        expect(new_board.squares.flatten.length).to eq(max_squares)
      end

      it 'has 32 nil squares' do
        nil_squares = 32
        expect(new_board.squares.flatten.count(nil)).to eq(nil_squares)
      end
    end

    context 'when game pieces are assigned to board' do
      it 'puts black pawn on A7' do
        a7 = new_board.squares[1][1]
        expect(a7).to be_a Pawn
        expect(a7.color).to be :black
      end

      it 'puts black king on F8' do
        f8 = new_board.squares[0][4]
        expect(f8).to be_a King
        expect(f8.color).to be :black
      end

      it 'puts white bishop on C1' do
        c1 = new_board.squares[7][2]
        expect(c1).to be_a Bishop
        expect(c1.color).to be :white
      end

      it 'puts white knight on G1' do
        g1 = new_board.squares[7][6]
        expect(g1).to be_a Knight
        expect(g1.color).to be :white
      end
    end
  end

  describe 'move_piece' do
    subject(:board) { Board.new }

    context 'when moving a pawn' do
      let(:start) { [[1, 0], [6, 0], [1, 6]] }
      let(:destination) { [[3, 0], [5, 0], [5, 6]] }

      it 'moves the pawn from the start square to the destination square' do
        pawn = board.squares[1][0]
        board.move_piece(start[0], destination[0])
        expect(board.squares[3][0]).to eq(pawn)
        expect(board.squares[1][0]).to be_nil
      end

      it 'moves white pawn one space forward to destination square' do
        pawn = board.squares[6][0]
        board.move_piece(start[1], destination[1])
        expect(board.squares[5][0]).to eq(pawn)
        expect(board.squares[6][0]).to be_nil
      end

      it 'fails to move pawn due to being out of range' do
        expect(board.move_piece(start[2], destination[2])).to be :invalid_move
      end
    end
  end
end
