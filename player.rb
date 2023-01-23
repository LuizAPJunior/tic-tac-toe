# frozen_string_literal: true

# The Player class represents the player and the marks of tic tac toe
class Player
  attr_accessor :name
  attr_reader :mark

  def initialize(name, mark)
    @name = name
    @mark = mark
  end
end
