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

      it 'moves black pawn from A7 to A5' do
        pawn = board.squares[1][0]
        board.move_piece(start[0], destination[0])
        expect(board.squares[3][0]).to eq(pawn)
        expect(board.squares[1][0]).to be_nil
      end

      it 'moves white pawn from A2 to A3' do
        pawn = board.squares[6][0]
        board.move_piece(start[1], destination[1])
        expect(board.squares[5][0]).to eq(pawn)
        expect(board.squares[6][0]).to be_nil
      end

      it 'fails to move black pawn from G7 to G2' do
        expect(board.move_piece(start[2], destination[2])).to be :invalid_move
      end
    end

    context 'when capturing another piece' do
      let(:white_pawn) { Pawn.new(:white) }
      let(:black_pawn) { Pawn.new(:black) }

      xit 'fails to capture piece on forward movement' do
        board.squares[4][1] = white_pawn
        board.squares[3][1] = black_pawn

        expect(board.move_piece([4, 1], [3, 1])).to be :invalid_move
      end
    end

    context 'when moving a knight' do
      let(:start) { [[7, 1], [7, 6], [0, 1], [0, 6]] }
      let(:destination) { [[5, 2], [5, 5], [2, 2], [2, 5]] }

      it 'moves white knight from B1 to C3' do
        knight = board.squares[7][1]
        board.move_piece(start[0], destination[0])
        expect(board.squares[5][2]).to eq(knight)
        expect(board.squares[7][1]).to be_nil
      end

      it 'moves white knight from G1 to F3' do
        knight = board.squares[7][6]
        board.move_piece(start[1], destination[1])
        expect(board.squares[5][5]).to eq(knight)
        expect(board.squares[7][6]).to be_nil
      end

      it 'moves black knight from B8 to C6' do
        knight = board.squares[0][1]
        board.move_piece(start[2], destination[2])
        expect(board.squares[2][2]).to eq(knight)
        expect(board.squares[0][1]).to be_nil
      end

      it 'moves black knight from G8 to F6' do
        knight = board.squares[0][6]
        board.move_piece(start[3], destination[3])
        expect(board.squares[2][5]).to eq(knight)
        expect(board.squares[0][6]).to be_nil
      end
    end

    context 'when moving a bishop' do
      let(:start) { [[7, 2], [7, 5], [0, 2], [0, 5]] }
      let(:destination) { [[4, 5], [4, 2], [3, 5], [3, 2]] }

      it 'fails move from C1 to F4 due to pawn on D2' do
        expect(board.move_piece(start[0], destination[0])).to be :invalid_move
      end

      it 'fails move from C1 to C4 due to invalid movement' do
        destination = board.squares[4][2]
        expect(board.move_piece(start[0], destination)).to be :invalid_move
      end

      it 'moves white bishop from C1 to F4' do
        board.squares[6][3] = nil
        bishop = board.squares[7][2]
        board.move_piece(start[0], destination[0])
        expect(board.squares[4][5]).to eq(bishop)
        expect(board.squares[7][2]).to be_nil
      end

      it 'moves white bishop from F1 to C4' do
        board.squares[6][4] = nil
        bishop = board.squares[7][5]
        board.move_piece(start[1], destination[1])
        expect(board.squares[4][2]).to eq(bishop)
        expect(board.squares[7][5]).to be_nil
      end
    end

    context 'when moving a queen' do
      let(:start) { [[7, 3], [5, 1], [3, 5]] }
      let(:destination) { [[4, 3], [4, 2], [5, 7]] }

      it 'fails move from D1 to D4 by being blocked by pawn' do
        expect(board.move_piece(start[0], destination[0])).to be :invalid_move
      end

      it 'moves white queen from B3 to C4' do
        board.squares[5][1] = Queen.new(:white)
        expect(board.move_piece(start[1], destination[1])).to be :success
      end

      it 'moves black queen from F5 to H3' do
        board.squares[3][5] = Queen.new(:black)
        expect(board.move_piece(start[2], destination[2])).to be :success
      end

      context 'when capturing another piece' do
        it 'white queen captures bishop on C4 from E2' do
          board.squares[4][2] = Bishop.new(:black)
          board.squares[6][4] = Queen.new(:white)
          expect(board.move_piece([6, 4], [4, 2])).to be :success
          expect(board.squares[4][2]).to be_a Queen
        end

        it 'black queen captures rook on H1 from H8' do
          board.squares[0][7] = Queen.new(:black)
          board.squares[1][7] = nil
          board.squares[6][7] = nil
          expect(board.move_piece([0, 7], [7, 7])).to be :success
          expect(board.squares[7][7]).to be_a Queen
        end
      end
    end
  end
end
