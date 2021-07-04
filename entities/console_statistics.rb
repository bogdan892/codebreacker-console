# frozen_string_literal: true

require 'yaml'
module ConsoleStatistics
  PATH_FILE = '../statistics.yml'

  def save_date(result)
    File.open(PATH_FILE, 'a') { |file| file.write(result.to_yaml) }
  end

  def load_from_db
    return [] unless File.exist?(PATH_FILE)

    results = YAML.load_stream(File.read(PATH_FILE))
    # sorted_results = results.sort_by { %i[difficulty attempts_used hints_used] }
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
                            'Attempts used',
                            'Hints used',
                            'Total attempt',
                            'Total hints'])
  end
end
