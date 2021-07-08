# frozen_string_literal: true

require 'yaml'
module ConsoleStatistics
  PATH_FILE = 'statistics.yml'

  def save_date(result)
    File.open(PATH_FILE, 'a') { |file| file.write(result.to_yaml) }
  end

  def load_from_db
    return [] unless File.exist?(PATH_FILE)

    results = YAML.load_stream(File.read(PATH_FILE))
    to_table(results)
  end

  private

  def to_table(results)
    table = initialize_table
    results.each do |result|
      table << result.values
    end
    table.render(alignment: :center)
  end

  def initialize_table
    TTY::Table.new(header: ['Name',
                            'Difficulty',
                            'Total attempt',
                            'Attempts used',
                            'Total hints',
                            'Hints used'])
  end
end
