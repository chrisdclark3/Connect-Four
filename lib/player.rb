class Player

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def play_turn
  	puts "Player #{@color}, enter a column number to play your piece: "
  	return gets.chomp.to_i
  end

  def token
    @color == :black ? "\u263A".encode('utf-8') : "\u263B".encode('utf-8')
  end

end
