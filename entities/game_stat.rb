# frozen_string_literal: true

class GameState
  def user_input
    command = gets.chomp
    user_exit if command == 'exit'
    command
  end

  def user_exit
    puts(I18n.t(:exit_message))
    exit
  end
end
