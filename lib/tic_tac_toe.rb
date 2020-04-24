class TicTacToe 

  def initialize
    @board = [" "," "," "," "," "," "," "," "," "]
  end 
  
 
  WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[6,4,2]]

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
    @board[cell] !=" "
  end 

  def valid_move?(index)
    !position_taken?(index) && index.between?(0,8) 
  end 

  def turn_count
		@board.count{|sq| sq != " " }
  end
  
	def current_player
		turn_count.even? ? "X" : "O"
  end
  
	def turn
    puts "Please enter a number (1-9):"
    user_input = gets.strip
    index = input_to_index(user_input)
    if valid_move?(index)
      token = current_player
      move(index, token)
    else
      turn
    end
    display_board
  end
  
	def won?
    WIN_COMBINATIONS.any? do |combo|
      if position_taken?(combo[0]) && @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]]
        return combo
      end
    end
  end
  
	def full?
		@board.all?{|sq| sq != " "}
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
		turn until over?
    puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
	end


end 