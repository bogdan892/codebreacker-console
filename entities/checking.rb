# frozen_string_literal: true

class Checking < GameState
  include Codebreaker::Validation
  def check_name(name)
    check_user(name)
  rescue StandardError
    player_name_again
  end

  def checks_difficulty(difficulty)
    check_difficulty(difficulty)
  rescue StandardError
    difficulty_again
  end

  def check_input(user_input)
    check_code(user_input)
  rescue StandardError
    player_input_again
  end
end
