module Games
  class Puzzle
    include Mongoid::Document

    field :pid, type: String # :participation_id
    field :size, type: Integer, default: 3 # Puzzle size
    field :grid, type: Array, default: [] # Puzzle array
    field :empty_position, type: Array, default: [] # Empty position in the grid

    index({ pid: 1 }, unique: true)

    def start(size = 3)
      self.size = size
      self.grid = (1...(size * size)).to_a.shuffle + [nil]
      self.grid = self.grid.each_slice(size).to_a
      self.empty_position = find_empty_position

      save
    end

    def move(direction)
      i, j = empty_position

      case direction
      when 'up'
        return false if i == 0
        swap(i, j, i - 1, j)
      when 'down'
        return false if i == size - 1
        swap(i, j, i + 1, j)
      when 'left'
        return false if j == 0
        swap(i, j, i, j - 1)
      when 'right'
        return false if j == size - 1
        swap(i, j, i, j + 1)
      else
        return false
      end
      self.empty_position = find_empty_position
      save
      
      true
    end

    def solved?
      flattened = grid.flatten.compact
      flattened == flattened.sort
    end

    private

    def find_empty_position
      grid.each_with_index do |row, i|
        j = row.index(nil)
        return [i, j] if j
      end

      nil
    end

    def swap(i1, j1, i2, j2)
      grid[i1][j1], grid[i2][j2] = grid[i2][j2], grid[i1][j1]
    end    
  end
end
