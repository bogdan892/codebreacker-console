# frozen_string_literal: true

RSpec.describe ConsolePlayer do
  subject(:registration) { described_class.new }

  describe 'when #player type name' do
    let(:incorrect_name) { 'qw' }

    it 'puts welcome message' do
      expect { registration.welcome }.to output("#{I18n.t(:Welcome)}\n").to_stdout
    end

    it 'invalid name' do
      allow(registration).to receive(:gets).and_return(incorrect_name)
      expect(registration).to receive(:player_name_again)
      registration.player_name
    end

    it 'puts enter name' do
      allow(registration).to receive(:user_input).and_return('name')
      expect { registration.player_name }.to output("#{I18n.t(:EnterName)}\n").to_stdout
    end

    it 'puts invalid name and enter name message' do
      allow(registration).to receive(:user_input).and_return('name')
      expect { registration.player_name_again }.to output("#{I18n.t(:InvalidName)}\n#{I18n.t(:EnterName)}\n").to_stdout
    end
  end

  describe 'when #player type difficulty' do
    let(:correct_difficulty) { 'hard' }
    let(:incorrect_difficulty) { 'foo' }

    it 'invalid difficulty' do
      allow(registration).to receive(:gets).and_return(incorrect_difficulty)
      expect(registration).to receive(:difficulty_again)
      registration.difficulty
    end

    it 'correct difficulty' do
      allow(registration).to receive(:user_input).and_return(correct_difficulty)
      expect(registration).not_to receive(:difficulty_again)
      registration.difficulty
    end

    it 'puts message if difficulty is incorrect' do
      allow(registration).to receive(:user_input).and_return('easy')
      expect do
        registration.difficulty_again
      end.to output("#{I18n.t(:InvalidDifficulty)}\n#{I18n.t(:EnterDifficulty)}\n").to_stdout
    end

    xit 'puts invalid name and enter name message' do
      allow(registration).to receive(:gets).and_return('name', 'exit')
      expect(registration).to have_received(:player_name)
      registration.call
    end
  end
end
