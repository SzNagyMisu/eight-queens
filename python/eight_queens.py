class ChessBoard(object):
    @classmethod
    def create(cls, pieces):
        squares = [[None for _ in range(8)] for _ in range(8)]
        for piece in pieces:
            squares[piece.row][piece.col] = piece.__str__()
        return cls(squares)

    def __init__(self, squares):
        self.squares = squares

    def draw(self):
        horizontal_line = "-" * 33 + "\n"
        print(horizontal_line +
              horizontal_line.join(
                  "| " +
                  " | ".join([square if square is not None else " " for square in line]) +
                  " |\n" for line in self.squares
              ) +
              horizontal_line)


class Piece(object):
    ROW_MIN = 0
    ROW_MAX = 7
    COL_MIN = 0
    COL_MAX = 7

    def __init__(self, row, col):
        self.row, self.col = row, col
        self._validate_position()

    def __repr__(self):
        return f"<{type(self).__name__} row={self.row} col={self.col}>"

    def _validate_position(self):
        if not (self.ROW_MIN <= self.row <= self.ROW_MAX and self.COL_MIN <= self.col <= self.COL_MAX):
            raise TypeError("Invalid values given - row and col should be between 0 and 7")

    def does_attack_square(self, square) -> bool:
        return square in self.attacked_squares()


class Queen(Piece):
    def __str__(self):
        return "Q"

    def attacked_squares(self) -> list[list[int, int]]:
        horizontal = [[self.row, col] for col in range(0, 8) if not col == self.col]
        vertical = [[row, self.col] for row in range(0, 8) if not row == self.row]
        row_col_diff = self.row - self.col
        diagonal_se_nw = [[row, row - row_col_diff] for row in range(0, 8) if not row == self.row]
        row_col_sum = self.row + self.col
        diagonal_sw_ne = [[row, row_col_sum - row] for row in range(0, 8) if not row == self.row]
        return horizontal + vertical + diagonal_se_nw + diagonal_sw_ne

