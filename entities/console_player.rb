# frozen_string_literal: true

class ConsolePlayer < Checking
  def call
    welcome
    player_name
    difficulty
    create_game
  end

  def welcome
    puts I18n.t(:welcome)
  end

  def player_name
    puts I18n.t(:enter_name)
    @player_name = user_input
    check_name(@player_name)
  end

  def player_name_again
    puts I18n.t(:invalid_name)
    player_name
  end

  def difficulty
    puts I18n.t(:enter_difficulty)
    @difficulty = user_input
    checks_difficulty(@difficulty)
  end

  def difficulty_again
    puts I18n.t(:invalid_difficulty)
    difficulty
  end

  def create_game
    @console_base = ConsoleBases.new(@player_name, @difficulty).call
  end
end
