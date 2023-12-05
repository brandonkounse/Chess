# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/board'

describe Board do
  describe '#initialize' do
    subject(:new_board) { described_class.new }

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

  describe '#move_piece' do
    subject(:board) { described_class.new }

    context 'when moving a pawn' do
      let(:start) { [[1, 0], [6, 0]] }
      let(:dest) { [[3, 0], [5, 0]] }

      it 'moves black pawn from A7 to A5' do
        pawn = board.squares[1][0]
        board.move_piece(start[0], dest[0])
        expect(board.squares[3][0]).to eq(pawn)
        expect(board.squares[1][0]).to be_nil
      end

      it 'moves white pawn from A2 to A3' do
        pawn = board.squares[6][0]
        board.move_piece(start[1], dest[1])
        expect(board.squares[5][0]).to eq(pawn)
        expect(board.squares[6][0]).to be_nil
      end
    end

    context 'when moving a knight' do
      let(:start) { [[7, 1], [7, 6], [0, 1], [0, 6]] }
      let(:dest) { [[5, 2], [5, 5], [2, 2], [2, 5]] }

      it 'moves white knight from B1 to C3' do
        knight = board.squares[7][1]
        board.move_piece(start[0], dest[0])
        expect(board.squares[5][2]).to eq(knight)
        expect(board.squares[7][1]).to be_nil
      end

      it 'moves white knight from G1 to F3' do
        knight = board.squares[7][6]
        board.move_piece(start[1], dest[1])
        expect(board.squares[5][5]).to eq(knight)
        expect(board.squares[7][6]).to be_nil
      end

      it 'moves black knight from B8 to C6' do
        knight = board.squares[0][1]
        board.move_piece(start[2], dest[2])
        expect(board.squares[2][2]).to eq(knight)
        expect(board.squares[0][1]).to be_nil
      end

      it 'moves black knight from G8 to F6' do
        knight = board.squares[0][6]
        board.move_piece(start[3], dest[3])
        expect(board.squares[2][5]).to eq(knight)
        expect(board.squares[0][6]).to be_nil
      end
    end

    context 'when moving a bishop' do
      let(:start) { [[7, 2], [7, 5], [0, 2], [0, 5]] }
      let(:dest) { [[4, 5], [4, 2], [3, 5], [3, 2]] }

      it 'moves white bishop from C1 to F4' do
        board.squares[6][3] = nil
        bishop = board.squares[7][2]
        board.move_piece(start[0], dest[0])
        expect(board.squares[4][5]).to eq(bishop)
        expect(board.squares[7][2]).to be_nil
      end

      it 'moves white bishop from F1 to C4' do
        board.squares[6][4] = nil
        bishop = board.squares[7][5]
        board.move_piece(start[1], dest[1])
        expect(board.squares[4][2]).to eq(bishop)
        expect(board.squares[7][5]).to be_nil
      end
    end

    context 'when moving a queen' do
      let(:start) { [[5, 1], [3, 5]] }
      let(:dest) { [[4, 2], [5, 7]] }

      it 'moves white queen from B3 to C4' do
        board.squares[5][1] = Queen.new(:white)
        board.move_piece(start[0], dest[0])
        expect(board.squares[4][2]).to be_a Queen
      end

      it 'moves black queen from F5 to H3' do
        board.squares[3][5] = Queen.new(:black)
        board.move_piece(start[1], dest[1])
        expect(board.squares[5][7]).to be_a Queen
      end
    end

    context 'when moving a rook' do
      let(:start) { [4, 3] }
      let(:dest) { [[4, 0], [5, 3], [4, 7]] }

      before do
        board.squares[4][3] = Rook.new(:black)
      end

      it 'moves black rook from D4 to A4' do
        board.move_piece(start, dest[0])
        expect(board.squares[4][0]).to be_a Rook
      end

      it 'moves black rook from D4 to D3' do
        board.move_piece(start, dest[1])
        expect(board.squares[5][3]).to be_a Rook
      end

      it 'moves black rook from D4 to H4' do
        board.move_piece(start, dest[2])
        expect(board.squares[4][7]).to be_a Rook
      end
    end
  end
end
