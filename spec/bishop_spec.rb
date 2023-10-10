# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/bishop'

describe Bishop do
  let(:white) { 'white' }
  let(:black) { 'black' }

  describe 'initialize' do
    context 'when a new bishop is created' do
      subject(:new_bishop) { Bishop.new(white) }

      it 'assigns color to the piece' do
        color = white
        expect(new_bishop.color).to eq(color)
      end
    end
  end
end
