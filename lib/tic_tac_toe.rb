
class TicTacToe
	def initialize()
		@board = Array.new(9, " ")

	end
	WIN_COMBINATIONS = [
		[0,1,2],
		[3,4,5],
		[6,7,8],
		[0,3,6],
		[1,4,7],
		[2,5,8],
		[0,4,8],
		[2,4,6]
	]
	def display_board
		current_board = ""
		(0..2).each do |row|
			board_row = ""
			(0..2).each do |space|
				board_row += " #{@board[(3 * row) + space]} "
				board_row += "|" unless space == 2
			end
			current_board += board_row
			current_board += "\n------------\n" unless row == 2
		end
		puts current_board
	end
	def input_to_index(user_input)
		user_input.to_i - 1
	end
	def move(cell, mark)
		@board[cell] = mark
	end
	def position_taken?(cell)
		@board[cell] != " "
	end
	def valid_move?(move)
		!position_taken?(move) && [*0..8].include?(move)
	end
	def turn_count
		@board.reduce(0) { |acc, cell| cell == " " ? acc : acc + 1 }
	end
	def current_player
		turn_count % 2 == 0 ? "X" : "O"
	end
	def turn
		player_move = ""
		loop do 
		  player_move = input_to_index(gets.chomp)
		  break if valid_move?(player_move)
		end
		move(player_move, current_player)
		display_board
	end
	def won?
		p1_wins = false
		p2_wins = false
		winning_combo = nil
		WIN_COMBINATIONS.each do |combo|
			p1_wins = (combo - p1_moves).empty? || p1_wins
			p2_wins = (combo - p2_moves).empty? || p2_wins
			winning_combo ||= combo if p1_wins || p2_wins
		end
		(p1_wins || p2_wins) ? winning_combo : false
	end
	def full?
		([*0..8] - (p1_moves + p2_moves)).empty?
	end
	def p1_moves
		p1_moves = []
		@board.each_with_index do |cell, i|
			cell == "X" && p1_moves << i
		end
		p1_moves
	end
	def p2_moves
		p2_moves = []
		@board.each_with_index do |cell, i|
			cell == "O" && p2_moves << i
		end
		p2_moves
	end
	def draw?
		full? && !won?
	end
	def over?
		draw? || won?
	end
	def winner
		won? ? { "O" => "X", "X" => "O"}[current_player] : nil
	end
	def play
		while !over?
			turn
		end
		draw? ? puts("Cat's Game!") : puts("Congratulations #{winner}!")
	end

end