require 'spec_helper'

describe Games::Puzzle do

  describe "#start" do
    it do
      puzzle = Games::Puzzle.new
      puzzle.start

      expect(puzzle.size).to eq(3)
      expect(puzzle.empty_position).to eq([2, 2])
    end
  end

  describe "#solved?" do
    it do
      puzzle = Games::Puzzle.new
      puzzle.start(2)

      expect(puzzle.size).to eq(2)
      expect(puzzle.solved?).to eq(false)

      puzzle.move('left')
      puzzle.move('up')
      puzzle.move('right')      

      expect(puzzle.solved?).to eq(true)
    end
  end

  describe "#move" do
    it do
      puzzle = Games::Puzzle.new
      puzzle.start

      expect(puzzle.move('up')).to eq(true)
      expect(puzzle.move('right')).to eq(false)
      expect(puzzle.move('test')).to eq(false)
      expect(puzzle.move('left')).to eq(true)

      expect(puzzle.empty_position).to eq([1,1])
    end
  end
end
