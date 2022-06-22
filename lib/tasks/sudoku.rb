

def find_empty_positions(board)
  empty_positions = []

  for row in 0...board.length
    for col in 0...board[row].length
      empty_positions << [row, col] if board[row][col] == 0
    end
  end

  empty_positions
end

def check_row(board, row, number)
  for col in 0...board[row].length
    return false if board[row][col] == number
  end

  true
end

def check_col(board, col, number)
  for row in 0...board.length
    return false if board[row][col] == number
  end

  true
end

def check_block(board, row, col, number)
  lower_row = 3 * (row / 3)
  lower_col = 3 * (col / 3)
  upper_row = lower_row + 3
  upper_col = lower_col + 3

  for r in lower_row...upper_row
    for c in lower_col...upper_col
      return false if board[r][c] == number
    end
  end

  true
end

def check_value(board, row, col, number)
  check_row(board, row, number) &&
    check_col(board, col, number) &&
    check_block(board, row, col, number)
end

def solve_puzzle(board, empty_positions)
  i = 0

  while i < empty_positions.length
    row = empty_positions[i][0]
    column = empty_positions[i][1]
    number = board[row][column] + 1
    found = false

    while !found && number <= 9
      if check_value(board, row, column, number)
        found = true
        board[row][column] = number
        i += 1
      else
        number += 1
      end
    end

    unless found
      board[row][column] = 0
      i -= 1
    end
  end

  board
end


