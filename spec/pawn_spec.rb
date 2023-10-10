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
    end
  end
end
