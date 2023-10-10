# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/rook'

describe Rook do
  let(:white) { 'white' }
  let(:black) { 'black' }

  describe 'initialize' do
    context 'when a new rook is created' do
      subject(:new_rook) { Rook.new(white) }

      it 'assigns color to the piece' do
        color = white
        expect(new_rook.color).to eq(color)
      end
    end
  end
end
