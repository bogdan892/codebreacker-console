# frozen_string_literal: true

class ConsolePlayer < Checking
  def call
    welcome
    player_name
    difficulty
    create_game
  end

  def welcome
    puts I18n.t(:Welcome)
  end

  def player_name
    puts I18n.t(:EnterName)
    @player_name = user_input
    check_name(@player_name)
  end

  def player_name_again
    puts I18n.t(:InvalidName)
    player_name
  end

  def difficulty
    puts I18n.t(:EnterDifficulty)
    @difficulty = user_input
    checks_difficulty(@difficulty)
  end

  def difficulty_again
    puts I18n.t(:InvalidDifficulty)
    difficulty
  end

  def create_game
    @console_base = ConsoleBases.new(@player_name, @difficulty).call
  end
end
