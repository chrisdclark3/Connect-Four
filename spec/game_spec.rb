require 'spec_helper'

describe Game do

	before :each do
		board = Board.new(7,6,4)
		@game = Game.new(board)
	end

	describe "#check_winner" do

		it "successfully confirms a right diagonal winner" do
			@game.board.grid[0][0] = @game.player1.token
			@game.board.grid[1][1] = @game.player1.token
			@game.board.grid[2][2] = @game.player1.token
			@game.board.grid[3][3] = @game.player1.token
			expect(@game.check_winner(3, 3)).to be_truthy
		end

		it "successfully confirms a left diagonal winner" do
			@game.board.grid[4][4] = @game.player1.token
			@game.board.grid[3][3] = @game.player1.token
			@game.board.grid[2][2] = @game.player1.token
			@game.board.grid[1][1] = @game.player1.token
			expect(@game.check_winner(2, 2)).to be_truthy
		end

		it "successfully confirms a horizontal winner" do
			@game.board.grid[1][2] = @game.player1.token
			@game.board.grid[1][3] = @game.player1.token
			@game.board.grid[1][4] = @game.player1.token
			@game.board.grid[1][5] = @game.player1.token
			expect(@game.check_winner(1, 4)).to be_truthy
		end

		it "successfully confirms a vertical winner" do
			@game.board.grid[3][2] = @game.player1.token
			@game.board.grid[4][2] = @game.player1.token
			@game.board.grid[5][2] = @game.player1.token
			@game.board.grid[6][2] = @game.player1.token
			expect(@game.check_winner(2, 2)).to be_truthy
		end

	end

end



