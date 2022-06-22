class SudokuController < ApplicationController
  def begin
    arr = params[:data]
    # render json: { my_arr: [arr] }

    empty_positions = []

    for row in 0...arr.length
      for col in 0...arr[row].length
        arr[row][col] = 0 if arr[row][col].nil?
        # empty_positions << [row, col] if arr[row][col] == 0
      end
    end
    for row in 0...arr.length
      for col in 0...arr[row].length
        empty_positions << [row, col] if arr[row][col] == 0
      end
    end
    # render json: { my_arr: [arr] }
    render json: { emoty: empty_positions }
    i = 0

    while i < empty_positions.length
      row = empty_positions[i][0]
      column = empty_positions[i][1]
      !arr[row][column].nil?
      number = arr[row][column] + 1

      found = false

      while !found && number <= 9
        if check_value(arr, row, column, number)
          found = true
          arr[row][column] = number
          i += 1
        else
          number += 1
        end
      end

      unless found
        arr[row][column] = 0
        i -= 1
      end
    end
    # { json: arr }
    # render json: { solution: arr }
  end

  def check_row(arr, row, number)
    for col in 0...arr[row].length
      return false if arr[row][col] == number
    end

    true
  end

  def check_col(arr, col, number)
    for row in 0...arr.length
      return false if arr[row][col] == number
    end

    true
  end

  def check_block(arr, row, col, number)
    lower_row = 3 * (row / 3)
    lower_col = 3 * (col / 3)
    upper_row = lower_row + 3
    upper_col = lower_col + 3

    for r in lower_row...upper_row
      for c in lower_col...upper_col
        return false if arr[r][c] == number
      end
    end

    true
  end

  def check_value(arr, row, col, number)
    check_row(arr, row, number) &&
      check_col(arr, col, number) &&
      check_block(arr, row, col, number)
  end
end
