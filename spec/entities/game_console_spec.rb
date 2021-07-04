# frozen_string_literal: true

require_relative '../spec_helper'
RSpec.describe GameConsole do
  let(:console) { described_class.new }
  let(:interface) { console.instance_variable_get(:@game) }

  describe 'when #start' do
    it 'when #initialize set Interface instance' do
      expect(console.instance_variable_get(:@game)).to be_instance_of ConsoleOptions
    end

    # it 'when #initialize set Interface instance' do
    #   allow(console).to receive(:start)
    #   expect(interface).to receive(:show_main_menu)
    # end
  end
end
