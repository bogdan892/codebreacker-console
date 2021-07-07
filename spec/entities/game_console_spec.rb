# frozen_string_literal: true

require_relative '../spec_helper'
RSpec.describe GameConsole do
  let(:console) { described_class.new }
  let(:interface) { console.instance_variable_get(:@game) }

  describe 'when GameConsole' do
    it '#initialize set ConsoleOptions instance' do
      expect(console.instance_variable_get(:@game)).to be_instance_of ConsoleOptions
    end

    it 'when #start show main menu' do
      allow(console).to receive(:gets).and_return('exit')
      allow(interface).to receive(:show_main_menu)
      console.start
    end
  end
end
