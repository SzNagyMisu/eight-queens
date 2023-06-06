require_relative 'eight_queens'

RSpec.describe Queen do
  describe '#row and #col' do
    it 'can be read.' do
      queen = Queen.new 3, 4
      expect(queen.row).to eq 3
      expect(queen.col).to eq 4
    end
  end

  describe 'initialization' do
    it 'raises ArgumentError if row or col is out of constraints.' do
      expect { Queen.new -1, 4 }.to raise_exception ArgumentError
      expect { Queen.new 4, 8 }.to raise_exception ArgumentError
    end
  end

  describe '#attacked_squares' do
    subject(:queen) { Queen.new 4, 4 }

    it 'includes horizontal attacked sqares.' do
      horizontal_attacked_squares = [
        [4, 0], [4, 1], [4, 2], [4, 3], [4, 5], [4, 6], [4, 7],
      ]
      expect(horizontal_attacked_squares - queen.attacked_squares).to eq []
    end

    it 'includes vertical attacked squares.' do
      vertical_attacked_squares = [
        [0, 4], [1, 4], [2, 4], [3, 4], [5, 4], [6, 4], [7, 4], 
      ]
      expect(vertical_attacked_squares - queen.attacked_squares).to eq []
    end

    it 'includes diagonal attacked squares.' do
      diagonal_attacked_squares = [
        [0, 0], [1, 1], [2, 2], [3, 3], [5, 5], [6, 6], [7, 7],
        [7, 1], [6, 2], [5, 3], [3, 5], [2, 6], [1, 7],
      ]
      expect(diagonal_attacked_squares - queen.attacked_squares).to eq []
    end
  end

  describe '#attacks? square' do
    subject(:queen) { Queen.new 2, 5 }

    it 'returns true if queen attacks given square.' do
      expect(queen.attacks? [4, 7]).to be true
      expect(queen.attacks? [2, 3]).to be true
      expect(queen.attacks? [1, 5]).to be true
    end

    it 'returns false if queen does not attack given square.' do
      expect(queen.attacks? [3, 7]).to be false
      expect(queen.attacks? [0, 0]).to be false
      expect(queen.attacks? [7, 1]).to be false
    end
  end
end
