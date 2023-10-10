# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/king'

describe King do
  let(:white) { 'white' }
  let(:black) { 'black' }

  describe 'initialize' do
    context 'when a new king is created' do
      subject(:new_king) { King.new(white) }

      it 'assigns color to the piece' do
        color = white
        expect(new_king.color).to eq(color)
      end
    end
  end
end
