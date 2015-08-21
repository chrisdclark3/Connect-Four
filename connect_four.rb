Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }
if __FILE__ == 'connect_four.rb'
  g = Game.new
  g.run_game
end
