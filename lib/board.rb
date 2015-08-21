class Board

  # attr methods, constants and initialize

  attr_accessor :grid, :rows, :columns, :winning_length

  BLANK = "_"

  def initialize(row=nil, col=nil, win=nil)
    @rows = row == nil ? rows : row
    @columns = col == nil ? columns : col
    @winning_length = win == nil ? winning_length : win
    @grid = Array.new(@rows.to_i) { Array.new(@columns.to_i) { |i| i = BLANK } }
  end


  # initialize rows, columns and winning length with user input

  def columns
    return @columns if @columns != nil
    puts "Enter number of columns (ex. 7):"
    err = "Please pick an integer greater than 2"
    validate(err) { |i| i >= 2 }
  end

  def rows
    return @rows if @rows != nil
    puts "Enter number of rows (ex. 6):"
    err = "Please pick an integer greater than 2"
    validate(err) { |i| i >= 2 }
  end

  def winning_length
    return @winning_length if @winning_length != nil
    puts "Enter a winning line length (ex. 4)"
    max = @columns < @rows ? @columns : @rows
    err = "Please pick an integer that is less then #{max}"
    validate(err) { |i| i >= 2 && i < max }
  end

  # validate user inputs

  def validate(err, input=nil, &block)
    begin
      input = input == nil ? STDIN.gets.chomp.to_i : input
      block.(input) ? (return input) : (raise err)
    rescue => e
      puts "Error: #{e.message}"
      input = nil
      retry
    end
  end

  def validate_turn(col)
    # make sure column is on board
    input = validate_on_board(col)
    # make sure column isn't full and return
    validate_column_space(input)
  end

  def validate_on_board(col)
    err = "Move is invalid. Column must be between 0 and #{@columns - 1}"
    validate(err, col) { |i| i.between?(0, @columns) }
  end

  def validate_column_space(col)
    err = "Move is invalid. Column can't be full"
    validate(err, col) { |i| blank?(0, i) }
  end

  # boolean validations for game methods that access the board

  def blank?(row, col)
    @grid[row][col] == BLANK ? true : false
  end

  def in_play?(row, col)
    if ((row >= 0 && row < @rows) && (col >= 0 && col < @columns))
      true
    else
      false
    end
  end

  # format and render grid

  def format_cell(cell)
    cell.is_a?(Integer) ? "  " + cell.to_s + "  " : " |" + cell.to_s + "| "
  end

  def render
    top_row = "     "
    @columns.times { |x| top_row << format_cell(x) }
    puts top_row
    @grid.each_with_index do |row, idx|
      current = "" << format_cell(idx)
      row.each { |cell| current << format_cell(cell) }
      puts current
    end
  end

end
