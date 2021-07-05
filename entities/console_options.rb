# frozen_string_literal: true

class ConsoleOptions < GameState
  attr_accessor :context

  include ConsoleStatistics

  def show_main_menu
    puts I18n.t(:Welcome)
    puts I18n.t(:MainMenu)
    @command = user_input
    console_option
  end

  def main_menu_error
    puts I18n.t(:InvalidCommand)
    show_main_menu
  end

  def console_option
    case @command
    when 'start' then registration
    when 'rules' then game_rules
    when 'stats' then game_stats
    else main_menu_error
    end
  end

  def game_start
    show_main_menu
  end

  def game_rules
    puts I18n.t(:Rules)
    show_main_menu
  end

  def game_stats
    puts load_from_db
    show_main_menu
  end

  def registration
    @registration = ConsolePlayer.new.call
  end
end
