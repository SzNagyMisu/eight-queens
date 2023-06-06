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
    def __init__(self, row, col):
        self.row, self.col = row, col


class Queen(Piece):
    def __str__(self):
        return "Q"
