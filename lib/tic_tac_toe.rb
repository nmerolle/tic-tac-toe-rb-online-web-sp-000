def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index,current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
count = 0  
  board.each do |token|
    if token == "X" || token == "O"
    count += 1
    end
  end
  count
end

def current_player(board)
  if turn_count(board) % 2 == 0
     "X"
  else
     "O"
  end
end

WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

def won?(board)
  WIN_COMBINATIONS.each do |win|
    index_1 = win[0]
    index_2 = win[1]
    index_3 = win[2]
    
    pos_1 = board[index_1]
    pos_2 = board[index_2]
    pos_3 = board[index_3]
    
    if pos_1 == pos_2&&pos_2==pos_3&&position_taken?(board, index_3)
      return win
    end
  end
  false
end

def full?(board)
    if board.any? {|i| i==" "}
    return false
    else 
    true 
    end
end

def draw?(board)
    full=full?(board)
    if !won?(board)&&full
      return true
    elsif !full&&!won?(board)
      return false
    else return false
    end  
end

def over?(board)
  if draw?(board)||won?(board)||full?(board)
    return true
  else
    return false
  end
end

 def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  end
end     



def play(board)
  while !over?(board) && !won?(board) && !draw?(board) 
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
    puts "Cat's Game!"
  end
end

