require_relative 'board'
require_relative 'player'

class Game

  # attr_methods, constants and initialize

  attr_reader :player1, :player2
  attr_accessor :board

  DIRECTIONS = [
    # [ R,  C]
    [ 0, -1], # Left
    [ 0,  1], # Right
    [-1, -1], # Up Left
    [ 1,  1], # Down Right
    [-1,  1], # Up Right
    [ 1, -1], # Down Left
    [ 1,  0]  # Down
  ]

  def initialize(board=Board.new)
    @board = board
    @player1 = Player.new(:white)
    @player2 = Player.new(:black)
    @current_player = @player1
    @winner = nil
  end

  # logic for player turns

  def get_turn
    turn = @current_player.play_turn
    return @board.validate_turn(turn)
  end

  def set_turn(col)
    (@board.grid.length - 1).downto(0) do |row|
      if @board.blank?(row, col)
        @board.grid[row][col] = @current_player.token
        return row
      end
    end
  end

  def set_current_player
    @current_player = (@current_player == @player1 ? @player2 : @player1)
    puts "\nIt's player #{@current_player.color}'s turn"
  end

  def run_turn
    col = get_turn
    row = set_turn(col)
    @board.render
    if check_winner(row, col)
      @winner = @current_player
      return
    end
    set_current_player
  end

  # check if a given turn results in a winner

  def check_winner(row, col)
    count = 0
    arr = [[row, col]]
    DIRECTIONS.each do |dir|
      count += 1
      r, c = row + dir[0], col + dir[1]
      if @board.in_play?(r, c)
        play = @board.grid[r][c]
        while (play == @current_player.token && @board.in_play?(r, c))
          arr << [r, c]
          return true if arr.length == @board.winning_length
          play = @board.grid[r][c]
          r, c = r + dir[0], c + dir[1]
        end
      end
      if count % 2 == 0
        count = 0
        arr = [[row, col]]
      end
    end
    return false
  end

  # run game to completion

  def run_game
    @board.render
    turns = 0
    until (@winner != nil || turns >= (@board.rows * @board.columns))
      run_turn
      turns += 1
    end
    if @winner != nil
      puts "CONGRATULATIONS PLAYER " + @winner.color.to_s + " YOU WON!!!"
    else
      puts "ITS A DRAW"
    end
  end

end

if __FILE__ == 'game.rb'
  g = Game.new
  g.run_game
end
