# frozen_string_literal: true

RSpec.describe ConsoleOptions do
  subject(:console_options) { described_class.new }

  let(:start) { 'start' }
  let(:stats) { 'stats' }
  let(:rules) { 'rules' }
  let(:exit) { 'exit' }
  let(:invalid_command) { 'foo' }

  describe 'when #show_main_menu' do
    it 'user choose start game' do
      allow(console_options).to receive(:user_input).and_return(start)
      expect(console_options).to receive(:registration)
      console_options.show_main_menu
    end

    it 'user choose show stats' do
      allow(console_options).to receive(:user_input).and_return(stats)
      expect(console_options).to receive(:game_stats)
      console_options.show_main_menu
    end

    it 'user choose show rules' do
      allow(console_options).to receive(:user_input).and_return(rules)
      expect(console_options).to receive(:game_rules)
      console_options.show_main_menu
    end

    it 'user type incorrect value' do
      allow(console_options).to receive(:user_input).and_return(invalid_command)
      expect(console_options).to receive(:main_menu_error)
      console_options.show_main_menu
    end

    it 'when game start' do
      allow(console_options).to receive(:user_input).and_return(invalid_command)
      expect(console_options).to receive(:show_main_menu)
      console_options.game_start
    end

    it 'when user type game rules' do
      allow(console_options).to receive(:user_input).and_return('rules')
      expect(console_options).to receive(:show_main_menu)
      console_options.game_rules
    end

    it 'when user type invalid command' do
      allow(console_options).to receive(:user_input).and_return(invalid_command)
      expect(console_options).to receive(:show_main_menu)
      console_options.main_menu_error
    end
  end
end
