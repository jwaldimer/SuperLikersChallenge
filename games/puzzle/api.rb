module Games
  class PuzzleApi < Sinatra::Base
    get '/puzzle/:pid/size/:size' do
      @game = Puzzle.where(pid: params[:pid]).first

      if @game.nil?
        @game = Puzzle.new( pid: params[:pid] )
        @game.start(params[:size].to_i)
      end

      Oj.dump(
        size: "#{@game.size}x#{@game.size}",
        grid: @game.grid.to_a,
        solved: @game.solved?
      )      
    end

    # Move the puzzle to up, down, left, right
    get '/puzzle/:pid/move/:direction' do
      @game = Puzzle.where(pid: params[:pid]).first
      direction = params['direction'].downcase
      ok = @game.move(direction)
      r_hash = {
        size: "#{@game.size}x#{@game.size}",
        grid: @game.grid,
        solved: @game.solved?
      }

      r_hash.merge!( status: 'Invalid move!' ) unless ok

      Oj.dump(r_hash)      
    end
  end
end
