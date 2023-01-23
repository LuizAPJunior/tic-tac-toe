# frozen_string_literal: true

require_relative 'board'
require_relative 'player'

# Class that represents the game loop of tic tac toe
class Game
  attr_accessor :game_loop, :current_player

  def initialize(board, player1, player2)
    @board = board
    @player1 = player1
    @player2 = player2
    @game_loop = true
    @current_player = player1
  end

  private

  def setup_game
    puts "#{@player1.name} plays with #{@player1.mark} and #{@player2.name} plays with #{@player2.mark}"
    @board.start_board
  end

  def mark_input(player)
    puts "#{player.name} type the row position in the board"
    row = gets.chomp.to_i
    puts "#{player.name} type the col position in the board"
    col = gets.chomp.to_i
    [row, col]
  end

  def game_over(end_game)
    case end_game
    when -1 then puts "It's a draw!"
    when 3 then puts "#{@player1.name} won!"
    when -3 then puts "#{@player2.name} won!"
    end
    @game_loop = false
  end

  def check_board(mark_position)
    end_game = [-3, 3, -1]
    if @board.position_marked?(mark_position)
      puts 'choose another position this one was already marked.'
    else
      @board.put_mark(mark_position, @current_player.mark)
      @board.show_board
      game_over(@board.check_board) if end_game.include?(@board.check_board)
      @current_player = @current_player.mark == ' X ' ? @player2 : @player1
    end
  end

  public

  def start_game
    setup_game
    while @game_loop
      @current_player = @current_player.mark == ' X ' ? @player1 : @player2
      mark_position = mark_input(@current_player)
      check_board(mark_position)
    end
  end
end

player1 = Player.new('Deb Demure', ' X ')
player2 = Player.new('Mona D', ' O ')
board = Board.new
game = Game.new(board, player1, player2)
game.start_game
