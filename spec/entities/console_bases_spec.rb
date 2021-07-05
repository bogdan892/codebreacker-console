# frozen_string_literal: true

require_relative '../spec_helper'
RSpec.describe ConsoleBases do
  let(:console_base) { described_class.new(name, difficulty) }
  let(:interface) { console_base.instance_variable_get(:@game) }
  let(:name) { 'Foo' }
  let(:difficulty) { 'hard' }

  describe 'player start game' do
    it 'when enter code' do
      allow(console_base).to receive(:user_input).and_return('1234')
      expect { console_base.player_input }.to output("#{I18n.t(:AccompanyingMsg)}\n").to_stdout
    end

    it 'when enter invalid code' do
      allow(console_base).to receive(:user_input).and_return('1')
      expect(console_base).to receive(:player_input_again)
      console_base.player_input
    end

    it 'puts incorrect code' do
      allow(console_base).to receive(:gets).and_return('1234')
      expect do
        console_base.player_input_again
      end.to output("#{I18n.t(:InvalidCommand)}\n#{I18n.t(:AccompanyingMsg)}\n").to_stdout
    end

    it 'call to method show hint' do
      command = %w[1234 hint 1234]
      allow(console_base).to receive(:gets).and_return(*command)
      allow(console_base).to receive(:exit)
      expect(console_base).to receive(:show_hint)
      console_base.call
    end

    it 'show hint value' do
      console_base.game.instance_variable_set(:@secret_code_for_hints, '1234'.chars)
      allow(console_base).to receive(:gets).and_return('hint')
      expect { console_base.show_hint }.to output("4\n#{I18n.t(:AccompanyingMsg)}\n").to_stdout
    end

    it 'show message if hint attempts ended' do
      console_base.game.instance_variable_set(:@hints, 0)
      console_base.game.instance_variable_set(:@secret_code_for_hints, '1234'.chars)
      allow(console_base).to receive(:gets).and_return('hint')
      expect { console_base.show_hint }.to output("#{I18n.t(:HintsEnded)}\n#{I18n.t(:AccompanyingMsg)}\n").to_stdout
    end

    it 'if game won' do
      console_base.game.instance_variable_set(:@secret_code, '1234'.chars)
      allow(console_base).to receive(:gets).and_return('1234')
      expect { console_base.game_won }.to output("#{I18n.t(:Won)}\n1234\n").to_stdout
    end

    it 'if game lose' do
      console_base.game.instance_variable_set(:@secret_code, '1234'.chars)
      console_base.game.instance_variable_set(:@attempts, 1)
      allow(console_base).to receive(:gets).and_return('4321')
      expect { console_base.game_lose }.to output("#{I18n.t(:Loss)}\n1234\n").to_stdout
    end

    it 'check input code ' do
      console_base.game.instance_variable_set(:@secret_code, '1234'.chars)
      allow(console_base).to receive(:gets).and_return('4321')
      expect { console_base.game_lose }.to output("#{I18n.t(:Loss)}\n1234\n").to_stdout
    end

    it 'puts message if save game' do
      console_base.game.instance_variable_set(:@secret_code, '1234'.chars)
      allow(console_base).to receive(:gets).and_return('1234', 'yes', 'exit')
      expect { console_base.save_game }.to output("#{I18n.t(:SaveResult)}\n").to_stdout
    end
  end
end
