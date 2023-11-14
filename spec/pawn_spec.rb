# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/pawn'

describe Pawn do
  let(:white) { :white }
  let(:black) { :black }

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

  describe 'can_move?' do
    context 'when white pawn' do
      subject(:white_pawn) { Pawn.new(white) }

      context 'when given valid path coordinates' do
        let(:start) { [[6, 1], [6, 4]] }
        let(:destination) { [[5, 1], [4, 4]] }

        it 'returns true with ([6, 1], [5, 1])' do
          expect(white_pawn.can_move?(start[0], destination[0])).to be true
        end

        it 'returns true with ([6, 4], [4, 4])' do
          expect(white_pawn.can_move?(start[1], destination[1])).to be true
        end
      end

      context 'when given invalid path coordinates' do
        let(:start) { [[6, 1], [6, 4]] }
        let(:destination) { [[4, 3], [3, 1]] }

        it 'returns false with ([6, 1], [4, 3])' do
          expect(white_pawn.can_move?(start[0], destination[0])).to be false
        end

        it 'returns false with ([6, 4], [3, 1])' do
          expect(white_pawn.can_move?(start[1], destination[1])).to be false
        end
      end
    end

    context 'when black pawn' do
      subject(:black_pawn) { Pawn.new(black) }

      context 'when given valid path coordinates' do
        let(:start) { [[1, 1], [1, 4]] }
        let(:destination) { [[3, 1], [2, 4]] }

        it 'returns true with ([1, 1], [3, 1])' do
          expect(black_pawn.can_move?(start[0], destination[0])).to be true
        end

        it 'returns true with ([1, 4], [2, 4])' do
          expect(black_pawn.can_move?(start[1], destination[1])).to be true
        end
      end

      context 'when given invalid path coordinates' do
        let(:start) { [[1, 1], [1, 4]] }
        let(:destination) { [[4, 3], [5, 5]] }

        it 'returns false with ([1, 1], [4, 3])' do
          expect(black_pawn.can_move?(start[0], destination[0])).to be false
        end

        it 'returns false with ([1, 4], [5, 5])' do
          expect(black_pawn.can_move?(start[1], destination[1])).to be false
        end
      end
    end
  end

  describe 'generate_path' do
    context 'when white pawn' do
      subject(:white_pawn) { Pawn.new(white) }

      context 'when given a valid path' do
        let(:start) { [6, 1] }
        let(:destination) { [4, 1] }

        it 'returns path array for ([6, 1], [4, 1])' do
          path = [[5, 1]]
          expect(white_pawn.generate_path(start, destination)).to eq(path)
        end
      end

      context 'when given an invalid path' do
        let(:start) { [[6, 1], [6, 4]] }
        let(:destination) { [[3, 1], [4, 7]] }

        it 'returns nil with ([6, 1], [3, 1])' do
          expect(white_pawn.generate_path(start[0], destination[0])).to be_nil
        end

        it 'returns nil with ([6, 4], [4, 7])' do
          expect(white_pawn.generate_path(start[1], destination[1])).to be_nil
        end
      end
    end

    context 'when black pawn' do
      subject(:black_pawn) { Pawn.new(black) }

      context 'when given a valid path' do
        let(:start) { [1, 3] }
        let(:destination) { [3, 3] }

        it 'returns path array for ([1, 3], [3, 3])' do
          path = [[2, 3]]
          expect(black_pawn.generate_path(start, destination)).to eq(path)
        end
      end

      context 'when given an invalid path' do
        let(:start) { [[1, 3], [1, 7]] }
        let(:destination) { [[2, 6], [4, 2]] }

        it 'returns nil with ([1, 3], [2, 6])' do
          expect(black_pawn.generate_path(start[0], destination[0])).to be_nil
        end

        it 'returns nil with ([1, 7], [4, 2])' do
          expect(black_pawn.generate_path(start[1], destination[1])).to be_nil
        end
      end
    end
  end

  describe 'check_move_status' do
    context 'when white pawn' do
      subject(:white_pawn) { Pawn.new(white) }

      it 'returns false if pawn has not moved' do
        position = [6, 1]
        expect(white_pawn.check_move_status(position)).to be false
      end

      it 'returns true if pawn has moved' do
        position = [5, 1]
        expect(white_pawn.check_move_status(position)).to be true
      end
    end

    context 'when black pawn' do
      subject(:black_pawn) { Pawn.new(black) }

      it 'returns false if pawn has not moved' do
        position = [1, 1]
        expect(black_pawn.check_move_status(position)).to be false
      end

      it 'returns true if pawn has moved' do
        position = [2, 1]
        expect(black_pawn.check_move_status(position)).to be true
      end
    end
  end
end
