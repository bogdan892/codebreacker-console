# frozen_string_literal: true

class ConsoleBases < Checking
  include ConsoleStatistics
  attr_reader :game

  def initialize(name, difficulty)
    @game = Codebreaker::Game.new(name, difficulty)
  end

  def call
    game.to_h[:attempts_total].times do
      player_input
      show_hint if @player_input == 'hint'
      game_code_check
      game_check_status
    end
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
    puts I18n.t(:Won)
    puts game.secrete_code
  end

  def game_lose
    puts I18n.t(:Loss)
    puts game.secrete_code
  end

  def save_game
    puts I18n.t(:SaveResult)
    @player_input = user_input
    save_date(game.to_h) if @player_input == 'yes'
  end

  def new_game
    puts I18n.t(:NewGame)
    @player_input = user_input
    if @player_input == 'yes'
      @console_game = ConsolePlayer.new.call
    else
      exit(true)
    end
  end

  def player_input_again
    puts I18n.t(:InvalidCommand)
    player_input
  end

  def show_hint
    @hint = game.use_hint
    if @hint == 'false'
      puts I18n.t(:HintsEnded)
      player_input
    else
      puts @hint
      player_input
    end
  end

  def player_input
    puts I18n.t(:AccompanyingMsg)
    @player_input = user_input
    check_input(@player_input)
  end

  private

  def game_code_check
    puts game.input_code(@player_input)
  end
end
