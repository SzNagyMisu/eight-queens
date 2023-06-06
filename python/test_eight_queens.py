import pytest

from eight_queens import Queen


class TestQueen(object):
    def test_init_stores_row_and_col(self):
        queen = Queen(3, 6)
        assert queen.row == 3
        assert queen.col == 6

    def test_str_repr_contains_queen_col_and_row(self):
        queen = Queen(4, 7)
        assert queen.__repr__() == "<Queen row=4 col=7>"

    def test_raises_type_error_if_row_or_col_out_of_board(self):
        with pytest.raises(TypeError):
            Queen(-1, 7)
        with pytest.raises(TypeError):
            Queen(1, 8)

    class TestAttackedSquares(object):
        def test_it_returns_a_list(self):
            queen = Queen(3, 4)
            assert isinstance(queen.attacked_squares(), list)

        def test_contains_horizontal_attacked_squares(self):
            queen = Queen(3, 4)
            expected_horizontal_squares = [[3, 0], [3, 1], [3, 2], [3, 3], [3, 5], [3, 6], [3, 7]]
            attacked_squares = queen.attacked_squares()
            assert all(square in attacked_squares for square in expected_horizontal_squares)

        def test_contains_vertical_attacked_squares(self):
            queen = Queen(3, 4)
            expected_vertical_squares = [[0, 4], [1, 4], [2, 4], [4, 4], [5, 4], [6, 4], [7, 4]]
            attacked_squares = queen.attacked_squares()
            assert all(square in attacked_squares for square in expected_vertical_squares)

        def test_contains_diagonal_attacked_sqares(self):
            queen = Queen(3, 4)
            expected_diagonal_squares = [
                [0, 1], [1, 2], [2, 3], [4, 5], [5, 6], [6, 7],
                [0, 7], [1, 6], [2, 5], [4, 3], [5, 2], [6, 1], [7, 0],
            ]
            attacked_squares = queen.attacked_squares()
            assert all(square in attacked_squares for square in expected_diagonal_squares)
