require 'rails_helper'
require '/home/puneeth/sudoku_api/lib/tasks/sudoku'
# require 'rspec'
# require_relative 'sudoku'

RSpec.describe 'Sudokus', type: :request do
  describe 'GET /index' do
    # pending "add some examples (or delete) #{__FILE__}"
  end
  describe 'Sudoku solver' do
    let(:board) do
      [
        [0, 9, 0, 0, 0, 0, 0, 0, 6],
        [0, 0, 0, 9, 6, 0, 4, 8, 5],
        [0, 0, 0, 5, 8, 1, 0, 0, 0],
        [0, 0, 4, 0, 0, 0, 0, 0, 0],
        [5, 1, 7, 2, 0, 0, 9, 0, 0],
        [6, 0, 2, 0, 0, 0, 3, 7, 0],
        [1, 0, 0, 8, 0, 4, 0, 2, 0],
        [7, 0, 6, 0, 0, 0, 8, 1, 0],
        [3, 0, 0, 0, 9, 0, 0, 0, 0]
      ]
    end

    let(:empty_positions) do
      [
        [0, 0], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7], [1, 0], [1, 1],
        [1, 2], [1, 5], [2, 0], [2, 1], [2, 2], [2, 6], [2, 7], [2, 8], [3, 0],
        [3, 1], [3, 3], [3, 4], [3, 5], [3, 6], [3, 7], [3, 8], [4, 4], [4, 5],
        [4, 7], [4, 8], [5, 1], [5, 3], [5, 4], [5, 5], [5, 8], [6, 1], [6, 2],
        [6, 4], [6, 6], [6, 8], [7, 1], [7, 3], [7, 4], [7, 5], [7, 8], [8, 1],
        [8, 2], [8, 3], [8, 5], [8, 6], [8, 7], [8, 8]
      ]
    end

    let(:solution) do
      [
        [8, 9, 5, 7, 4, 2, 1, 3, 6],
        [2, 7, 1, 9, 6, 3, 4, 8, 5],
        [4, 6, 3, 5, 8, 1, 7, 9, 2],
        [9, 3, 4, 6, 1, 7, 2, 5, 8],
        [5, 1, 7, 2, 3, 8, 9, 6, 4],
        [6, 8, 2, 4, 5, 9, 3, 7, 1],
        [1, 5, 9, 8, 7, 4, 6, 2, 3],
        [7, 4, 6, 3, 2, 5, 8, 1, 9],
        [3, 2, 8, 1, 9, 6, 5, 4, 7]
      ]
    end

    describe '#find_empty_positions' do
      subject { find_empty_positions(board) }

      it { should eq(empty_positions) }
    end

    describe '#check_row' do
      context 'when valid' do
        subject { check_row(board, 0, 2) }

        it { should eq(true) }
      end

      context 'when invalid' do
        subject { check_row(board, 0, 9) }

        it { should eq(false) }
      end
    end

    describe '#check_col' do
      context 'when valid' do
        subject { check_col(board, 0, 9) }

        it { should eq(true) }
      end

      context 'when invalid' do
        subject { check_col(board, 0, 5) }

        it { should eq(false) }
      end
    end

    describe '#check_block' do
      context 'when valid' do
        subject { check_block(board, 2, 2, 1) }

        it { should eq(true) }
      end

      context 'when invalid' do
        subject { check_block(board, 2, 2, 9) }

        it { should eq(false) }
      end
    end

    describe '#check_value' do
      context 'when valid' do
        subject { check_value(board, 0, 0, 2) }

        it { should eq(true) }
      end

      context 'when invalid' do
        subject { check_value(board, 0, 0, 9) }

        it { should eq(false) }
      end
    end

    describe '#solve_puzzle' do
      subject { solve_puzzle(board, empty_positions) }

      it { should eq(solution) }
    end
  end
end
