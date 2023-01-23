# frozen_string_literal: true

# Board class represents the board of the tic tac toe game
class Board
  attr_reader :numbers_board, :marks_board

  def initialize
    rows = 3
    cols = 3
    @numbers_board = Array.new(rows) { Array.new(cols) }
    @marks_board = Array.new(rows) { Array.new(cols) }
    @marks = { ' X ' => 1, ' O ' => -1 }
  end

  def start_board
    numbers_board_init = 0
    marks_board_init = ' * '
    @numbers_board.map! { |row| row.fill(numbers_board_init) }
    @marks_board.map! { |row| row.fill(marks_board_init) }
    print @numbers_board
    puts ''
  end

  def show_board
    @marks_board.each do |row|
      row.each do |mark|
        print mark
      end
      puts ''
    end
    puts ''
  end

  def position_marked?(mark_position)
    row = mark_position[0]
    col = mark_position[1]
    default_board_position = 0
    @numbers_board[row][col] != default_board_position
  end

  def put_mark(mark_position, mark)
    row = mark_position[0]
    col = mark_position[1]
    @marks_board[row][col] = mark
    @numbers_board[row][col] = @marks[mark]
  end

  def draw?
    default_board_position = 0
    result = @numbers_board.flatten.include?(default_board_position)
    puts result
    result == false
  end

  def check_rows
    victory = [-3, 3]
    game_continues = -10
    @numbers_board.each do |row|
      result = row.sum
      return result if victory.include?(result)
    end
    game_continues
  end

  def check_cols
    victory = [-3, 3]
    game_continues = -10
    @numbers_board.each_with_index do |_col, col_index|
      result = 0
      @numbers_board.each_with_index do |_row, row_index|
        result += @numbers_board [row_index][col_index]
      end
      return result if victory.include?(result)
    end
    game_continues
  end

  def diagonals_loop
    main_diagonal = 0
    secondary_diagonal = 0
    @numbers_board.each_with_index do |_row_element, row|
      @numbers_board.each_with_index do |_col_element, col|
        main_diagonal += @numbers_board[row][col] if row == col
        secondary_diagonal += @numbers_board[row][col] if (row - col).abs == 2 || row && col == 1
      end
    end
    [main_diagonal, secondary_diagonal]
  end

  def check_diagonals
    victory = [-3, 3]
    game_continues = -10
    main_diagonal = diagonals_loop[0]
    secondary_diagonal = diagonals_loop[1]
    return main_diagonal if victory.include?(main_diagonal)
    return secondary_diagonal if victory.include?(secondary_diagonal)

    game_continues
  end

  def check_board
    draw = -1
    victory = [-3, 3]
    game_continues = -10
    return check_rows if victory.include?(check_rows)
    return check_cols if victory.include?(check_cols)
    return check_diagonals if victory.include?(check_diagonals)
    return draw if draw?

    game_continues
  end
end
