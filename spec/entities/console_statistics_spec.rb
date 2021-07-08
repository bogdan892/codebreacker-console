# frozen_string_literal: true

require_relative '../spec_helper'
RSpec.describe ConsoleStatistics do
  let(:dummy) { Class.new { extend ConsoleStatistics } }
  let(:file_path) { 'spec/fixtures/test.yml' }
  let(:directory_name) { 'spec/fixtures' }
  let(:result) do
    { user: 'test user',
      difficulty: :easy,
      attempts_used: 10,
      hints_used: 2,
      total_attempt: 5,
      total_hint: 3 }
  end

  after do
    File.delete(file_path) if File.exist?(file_path)
    Dir.rmdir(directory_name) if File.exist?(directory_name)
  end

  before do
    Dir.mkdir(directory_name) unless File.exist?(directory_name)
    stub_const('ConsoleStatistics::PATH_FILE', file_path)
  end

  describe 'load from empty DB' do
    it { expect(dummy.load_from_db).to eq [] }
  end

  describe 'save to DB' do
    before { dummy.save_date(result) }

    it { expect(File.exist?(file_path)).to be true }

    it 'successfully save DB file ' do
      statistics = File.open(file_path, 'r', &:read)
      expect(statistics).to include('test user')
    end
  end

  describe 'load from DB' do
    before { dummy.save_date(result) }

    it 'load from BD' do
      result.each_value do |value|
        expect(dummy.load_from_db).to include(value.to_s)
      end
    end
  end
end
