class ChessBoard
  def self.create pieces
    squares = Array.new(8) { [nil] * 8 }
    pieces.each { |piece| squares[piece.row][piece.col] = piece.to_s }
    new squares
  end

  def initialize squares
    @squares = squares
  end

  def draw
    puts(horizontal_separator +
      @squares.map do |line|
        '| ' + line.map { |puppet| puppet || ' ' }.join(' | ') + " |\n"
      end.join(horizontal_separator) +
      horizontal_separator)
  end

  private
    
    def horizontal_separator
      '---' * 11 + "\n"
    end
end

class Queen
  COL_MIN = 0
  COL_MAX = 7
  ROW_MIN = 0
  ROW_MAX = 7

  attr_accessor :row, :col

  def initialize row, col
    validate_position! row, col
    @row, @col = row, col
  end

  def attacked_squares
    attacked_row + attacked_col + attacked_diag
  end

  def visualize
    board_data = Array.new(8) { [nil] * 8 }
    board_data[row][col] = to_s
    attacked_squares.each { |(row, col)| board_data[row][col] = 'x' }
    ChessBoard.new(board_data).draw
  end

  def attacks? square
    attacked_squares.include? square
  end

  def to_s
    'Q'
  end

  private

    def validate_position! row, col
      if row < ROW_MIN || row > ROW_MAX || col < COL_MIN || col > COL_MAX
        raise ArgumentError
      end
    end

    def attacked_row
      8.times.inject([]) { |squares, col| col == @col ? squares : squares + [[@row, col]] }
    end

    def attacked_col
      8.times.inject([]) { |squares, row| row == @row ? squares : squares + [[row, @col]] }
    end

    def attacked_diag
      row_col_diff = @row - @col
      row_col_sum = @row + @col
      nw_se_diag_squares = 8.times.inject([]) do |squares, col|
        row = row_col_diff + col
        row < ROW_MIN || row == @row || row > ROW_MAX ? squares : squares + [[row, col]]
      end
      ne_sw_diag_squares = 8.times.inject([]) do |squares, col|
        row = row_col_sum - col
        row < ROW_MIN || row == @row || row > ROW_MAX ? squares : squares + [[row, col]]
      end
      nw_se_diag_squares + ne_sw_diag_squares
    end
end

class EightQueens
  def self.solve queens = []
    @valid_setups = [] if queens.empty?
    if queens.size == 8
      @valid_setups << queens
      return
    end

    row = queens.size
    8.times do |col|
      new_setup = queens + [Queen.new(row, col)]
      solve(new_setup) if valid_setup?(new_setup)
    end

    @valid_setups
  end

  def self.valid_setup? queens
    queens.each_with_index.all? do |queen_a, i|
      queens[(i + 1)..].none? do |queen_b|
        queen_a.attacks? [queen_b.row, queen_b.col]
      end
    end
  end
end
