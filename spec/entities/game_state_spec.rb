# frozen_string_literal: true

RSpec.describe GameState do
  let(:game_state) { described_class.new }

  describe '#exit' do
    it 'when player exit game' do
      allow(game_state).to receive(:user_input).and_return('exit')
      instance_spy(game_state.user_exit).to receive(:exit)
    end
  end
end
