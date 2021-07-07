# frozen_string_literal: true

class ConsoleBases < Checking
  include ConsoleStatistics
  attr_reader :game

  def initialize(name, difficulty)
    super()
    @game = Codebreaker::Game.new(name, difficulty)
  end

  def call
    game.to_h[:attempts_total].times do
      player_input
      game_code_check
      game_check_status
      attemtps
    end
  end

  def attemtps
    puts I18n.t(:attempts_remain)
    puts game.instance_variable_get(:@attempts)
  end

  def game_check_status
    if game.won?
      game_won
      save_game
      new_game
    elsif game.lose?
      game_lose
      new_game
    end
  end

  def game_won
    puts I18n.t(:won)
    puts game.secrete_code
  end

  def game_lose
    puts I18n.t(:loss)
    puts game.secrete_code
  end

  def save_game
    puts I18n.t(:save_result)
    @player_input = user_input
    save_date(game.to_h) if @player_input == 'yes'
  end

  def new_game
    puts I18n.t(:new_game)
    @player_input = user_input
    if @player_input == 'yes'
      create_console
    else
      exit(true)
    end
  end

  def create_console
    @console_game = ConsolePlayer.new.call
  end

  def player_input_again
    puts I18n.t(:invalid_command)
    player_input
  end

  def show_hint
    @hint = game.use_hint
    if @hint == 'false'
      puts I18n.t(:hints_ended)
    else
      puts @hint
    end
    player_input
  end

  def player_input
    puts I18n.t(:accompanying_msg)
    @player_input = user_input
    @player_input == 'hint' ? show_hint : check_input(@player_input)
  end

  def game_code_check
    puts game.input_code(@player_input)
  end
end
