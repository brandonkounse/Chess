# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/queen'

describe Queen do
  let(:white) { 'white' }
  let(:black) { 'black' }

  describe 'initialize' do
    context 'when a new queen is created' do
      subject(:new_queen) { Queen.new(white) }

      it 'assigns color to the piece' do
        color = white
        expect(new_queen.color).to eq(color)
      end
    end
  end
end
