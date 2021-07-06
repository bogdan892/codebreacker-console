# frozen_string_literal: true

require 'bundler/setup'
require 'codebreaker'
require 'i18n'
require 'pry'
require 'tty-table'
require_relative 'i18n'
require_relative 'game_stat'
require_relative 'checking'
require_relative 'console_statistics'
require_relative 'console_bases'
require_relative 'console_options'
require_relative 'console_player'
class GameConsole < ConsoleOptions
  def initialize
    @game = ConsoleOptions.new
  end

  def start
    @game.show_main_menu
  end
end