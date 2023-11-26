# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/player'

describe Player do
  subject(:player) { Player.new(:white) }

  context 'when a new player is added' do
    context 'when a color is passed as an argument' do
      it 'assigns color to Player' do
        expect(player.color).to be :white
      end
    end
  end
end
