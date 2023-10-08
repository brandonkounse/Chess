# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/knight'

describe Knight do
  let(:white) { 'white' }
  let(:black) { 'black' }

  describe 'initialize' do
    context 'when a new knight is created' do
      subject(:new_knight) { Knight.new(white) }

      it 'assigns color to the piece' do
        color = white
        expect(new_knight.color).to eq(color)
      end
    end
  end
end
