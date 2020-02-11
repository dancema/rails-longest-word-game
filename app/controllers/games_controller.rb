class GamesController < ApplicationController
  require 'open-uri'
  require 'json'

  def new
    @letters = []
    prng = Random.new
    10.times do
      @letters << ('A'..'Z').to_a[prng.rand(23)]
    end
  end

  def score
    word_in_grid = true
    @word = params[:word].strip
    @grid = params[:grid]
    @word.split('').each do |letter|
      word_in_grid = false if @word.split('').count(letter) > @grid.count(letter.upcase)
    end

    if word_in_grid == false
      @result = 'not in the grid'
    else
      response = open("https://wagon-dictionary.herokuapp.com/#{@word}").read
      result_url = JSON.parse(response)
      @result = result_url['found']
    end
  end
end
