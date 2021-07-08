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
      expect { console_base.player_input }.to output("#{I18n.t(:accompanying_msg)}\n").to_stdout
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
      end.to output("#{I18n.t(:invalid_command)}\n#{I18n.t(:accompanying_msg)}\n").to_stdout
    end

    it 'check code when type code' do
      console_base.game.instance_variable_set(:@secret_code, '1233'.chars)
      console_base.instance_variable_set(:@player_input, '1234')
      console_base.game.instance_variable_set(:@input_code, '1234'.chars)
      allow(console_base).to receive(:player_input).and_return('1234')
      expect { console_base.game_code_check }.to output("+++\n").to_stdout
    end

    it "new game if type 'yes' on method call" do
      console_base.game.instance_variable_set(:@player_input, '1234'.chars)
      console_base.instance_variable_set(:@player_input, '1234')
      allow(console_base).to receive(:player_input).and_return('yes')
      expect(console_base).to receive(:new_game)
      console_base.call
    end

    it 'check game status' do
      console_base.game.instance_variable_set(:@secret_code, '1234'.chars)
      console_base.instance_variable_set(:@player_input, '1234'.chars)
      console_base.game.instance_variable_set(:@code_comprasions, '1234'.chars)
      allow(console_base).to receive(:game_won)
      allow(console_base).to receive(:save_game)
      expect(console_base).to receive(:new_game)
      console_base.game_check_status
    end

    it 'show hint value' do
      console_base.game.instance_variable_set(:@secret_code_for_hints, '1'.chars)
      allow(console_base).to receive(:player_input).and_return('1234')
      expect { console_base.show_hint }.to output("1\n").to_stdout
    end

    it 'show message if hint attempts ended' do
      console_base.game.instance_variable_set(:@hints, 0)
      console_base.game.instance_variable_set(:@secret_code_for_hints, '1234'.chars)
      allow(console_base).to receive(:player_input).and_return('hint')
      expect { console_base.show_hint }.to output("#{I18n.t(:hints_ended)}\n").to_stdout
    end

    it 'if game won' do
      console_base.game.instance_variable_set(:@secret_code, '1234'.chars)
      allow(console_base).to receive(:gets).and_return('1234')
      expect { console_base.game_won }.to output("#{I18n.t(:won)}\n1234\n").to_stdout
    end

    it 'if game lose' do
      console_base.game.instance_variable_set(:@secret_code, '1234'.chars)
      console_base.game.instance_variable_set(:@attempts, 1)
      allow(console_base).to receive(:gets).and_return('4321')
      expect { console_base.game_lose }.to output("#{I18n.t(:loss)}\n1234\n").to_stdout
    end

    it 'puts message if game lose ' do
      console_base.game.instance_variable_set(:@secret_code, '1234'.chars)
      allow(console_base).to receive(:gets).and_return('4321')
      expect { console_base.game_lose }.to output("#{I18n.t(:loss)}\n1234\n").to_stdout
    end

    it 'call to method attempts' do
      expect { console_base.attemtps }.to output("#{I18n.t(:attempts_remain)}\n5\n").to_stdout
      console_base.game_check_status
    end

    it 'new game if user type yes' do
      allow(console_base).to receive(:user_input).and_return('yes')
      console_base.game.instance_variable_set(:@secret_code, '1234'.chars)
      expect(console_base).to receive(:create_console)
      console_base.new_game
    end

    it 'exit if user type no' do
      allow(console_base).to receive(:user_input).and_return('no')
      console_base.game.instance_variable_set(:@secret_code, '1234'.chars)
      expect(console_base).to receive(:exit)
      console_base.new_game
    end
  end
end
