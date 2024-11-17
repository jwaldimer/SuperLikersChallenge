require 'spec_helper'

describe Games::PuzzleApi do
  let :puzzle do
    Games::Puzzle.create
  end

  describe ':init' do
    it do
      get '/puzzle/testN/size/3'
      expect(last_response).to be_ok
      body = Oj.load(last_response.body)
      expect(body[:solved]).to eq(false)
    end
  end

  describe ':move' do
    before(:each) do
      puzzle
      get '/puzzle/testN/size/3'
    end

    it do
      get '/puzzle/testN/move/right'
      expect(last_response).to be_ok

      body = Oj.load(last_response.body)
      expect(body[:status]).to eq('Invalid move!')
    end

    it do
      get '/puzzle/testN/move/up'
      expect(last_response).to be_ok

      body = Oj.load(last_response.body)
      expect(body[:solved]).to eq(false)
    end
  end
end
